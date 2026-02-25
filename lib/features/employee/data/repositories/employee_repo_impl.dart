import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_class_factory/core/errors/failure.dart';

import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/unknown_failure.dart';
import '../../../../core/firebase/firebase_service.dart';
import '../models/employee_model.dart';
import 'employee_repo.dart';

final String collectionName = "employees";

class EmployeeRepoImpl implements EmployeeRepo {
  final FirebaseService firebaseService;

  EmployeeRepoImpl(this.firebaseService);
  @override
  Future<Either<Failure, Unit>> addEmployee({required EmployeeModel employee}) async {
    try {
      await firebaseService.addData(collection: collectionName, data: employee.toJson());
      // final docRef = FirebaseFirestore.instance.collection(collectionName).doc();
      //
      // final EmployeeModel employeeWithId = employee.copyWith(id: docRef.id);
      //
      // await docRef.set(employeeWithId.toJson());

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteEmployee({required String id}) async {
    try {
      await firebaseService.delete(collection: collectionName, docId: id);
      // await FirebaseFirestore.instance.collection(collectionName).doc(id).delete();

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<EmployeeModel>>> getEmployee() async {
    try {
      final snapshot = await firebaseService.getAll(collection: collectionName);
      // final snapshot = await FirebaseFirestore.instance.collection(collectionName).get();
      final employees = snapshot.docs
          .map((doc) => EmployeeModel.fromJson(doc.data()))
          .toList();

      return right(employees);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateEmployee({required EmployeeModel employee}) async {
    try {
      await firebaseService.updateData(
        collection: collectionName,
        docId: employee.id,
        data: employee.toJson(),
      );
      // await FirebaseFirestore.instance
      //     .collection(collectionName)
      //     .doc(employee.id)
      //     .update(employee.toJson());

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FailureHandler.handle(e));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
