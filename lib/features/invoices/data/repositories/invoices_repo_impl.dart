import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../../../../core/firebase/firebase_service.dart';
import '../../../finishedProducts/data/models/color_stock.dart';
import '../../../finishedProducts/data/models/product_model.dart';
import '../../../finishedProducts/data/models/size_model.dart';
import '../models/invoice_model.dart';
import 'invoices_repo.dart';

class InvoicesRepoImpl implements InvoicesRepo {
  final FirebaseService firebaseService;

  InvoicesRepoImpl(this.firebaseService);
  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final snapshot = await firebaseService.getAllSubData(
        parentCollection: 'warehouses',
        parentDocId: "warehouse1_finished_products",
        subCollection: 'finished_products',
      );

      final products = snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();

      return right(products);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, InvoiceModel>> saveInvoice({
    required InvoiceModel invoice,
  }) async {
    try {
      final fireStore = FirebaseFirestore.instance;

      // مرجع الفاتورة الجديدة
      final invoiceRef = fireStore.collection("invoices").doc();

      // مرجع العداد
      final counterRef = fireStore.collection('counters').doc('invoice_counter');

      await fireStore.runTransaction((transaction) async {
        /// ==============================
        /// 1️⃣ أولاً نقرأ العداد (READ)
        /// ==============================

        final counterSnap = await transaction.get(counterRef);

        int nextNumber = 1;

        if (!counterSnap.exists) {
          // لو أول مرة
          nextNumber = 1;
        } else {
          final current = counterSnap.get("current") as int;
          nextNumber = current + 1;
        }

        final invoiceNumber = "INV-$nextNumber";

        /// ==============================
        /// 2️⃣ نقرأ كل المنتجات (READ ONLY)
        /// ==============================

        final productRefs = <DocumentReference>[];
        final productSnaps = <DocumentSnapshot>[];

        for (var item in invoice.items) {
          final ref = fireStore
              .collection('warehouses')
              .doc("warehouse1_finished_products")
              .collection('finished_products')
              .doc(item.id);

          productRefs.add(ref);
        }

        // قراءة كل المنتجات الأول
        for (var ref in productRefs) {
          final snap = await transaction.get(ref);

          if (!snap.exists) {
            throw Exception("منتج غير موجود");
          }

          productSnaps.add(snap);
        }

        /// ==============================
        /// 3️⃣ بعد ما خلصنا كل READ — نبدأ WRITE
        /// ==============================

        for (int i = 0; i < invoice.items.length; i++) {
          final item = invoice.items[i];
          final snapshot = productSnaps[i];
          final ref = productRefs[i];

          final product = ProductModel.fromMap(snapshot.data() as Map<String, dynamic>);

          final updatedSizes = product.sizes.map((sizeModel) {
            if (sizeModel.size != item.size) return sizeModel;

            final updatedColors = sizeModel.colors.map((colorStock) {
              if (colorStock.name != item.colorName) return colorStock;

              // تحقق من الكمية
              if (colorStock.qty < item.selectQty) {
                throw Exception("الكمية غير كافية");
              }

              // خصم الكمية
              return ColorStock(
                colorStock.name,
                colorStock.qty - item.selectQty,
                colorStock.color,
              );
            }).toList();

            return SizeModel(size: sizeModel.size, colors: updatedColors, isLow: false);
          }).toList();

          // تحديث المنتج
          transaction.update(ref, {'sizes': updatedSizes.map((e) => e.toMap()).toList()});
        }

        /// ==============================
        /// 4️⃣ تحديث العداد (WRITE)
        /// ==============================

        if (!counterSnap.exists) {
          transaction.set(counterRef, {"current": 1});
        } else {
          transaction.update(counterRef, {"current": nextNumber});
        }

        /// ==============================
        /// 5️⃣ حفظ الفاتورة (WRITE)
        /// ==============================

        final newInvoice = invoice.copyWith(
          id: invoiceRef.id,
          invoiceNumber: invoiceNumber,
        );

        transaction.set(invoiceRef, newInvoice.toJson());

        // نخزنها بره عشان نرجعها
        invoice = newInvoice;
      });

      return Right(invoice);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  Future<String> getNextInvoiceNumber() async {
    final docRef = FirebaseFirestore.instance
        .collection('counters')
        .doc('invoice_counter');

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        transaction.set(docRef, {"current": 1});
        return "INV-1";
      }

      final current = snapshot.get("current") as int;
      final next = current + 1;

      transaction.update(docRef, {"current": next});

      return "INV-$next";
    });
  }
}
