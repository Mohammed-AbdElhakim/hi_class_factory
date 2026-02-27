import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/app_strings.dart';

class FirebaseService {
  static const String factoryId = "hi_class";
  static const String collectionMain = "factories";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ================================
  /// 🔹 مرجع المصنع
  /// ================================

  CollectionReference<Map<String, dynamic>> _collection(String collection) {
    return _firestore.collection(collectionMain).doc(factoryId).collection(collection);
  }

  /// ================================
  /// تسجيل دخول
  /// ================================
  Future<UserCredential> login({
    required String username,
    required String password,
  }) async {
    final email = "$username${AppStrings.emailForm}";
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  /// ================================
  /// تسجيل خروج
  /// ================================
  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  /// ================================
  /// ➕ إضافة (ترجع ID)
  /// ================================
  Future<String> addData({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    final docRef = _collection(collection).doc();

    await docRef.set({...data, "id": docRef.id});

    return docRef.id;
  }

  /// ================================
  /// ✏️ تعديل
  /// ================================
  Future<void> updateData({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _collection(collection).doc(docId).update(data);
  }

  /// ================================
  /// 📥 جلب عنصر
  /// ================================
  Future<DocumentSnapshot<Map<String, dynamic>>> getById({
    required String collection,
    required String docId,
  }) async {
    return await _collection(collection).doc(docId).get();
  }

  /// ================================
  /// 📥 جلب الكل
  /// ================================
  Future<QuerySnapshot<Map<String, dynamic>>> getAll({required String collection}) async {
    return await _collection(collection).get();
  }

  /// ================================
  /// ❌ حذف
  /// ================================
  Future<void> delete({required String collection, required String docId}) async {
    await _collection(collection).doc(docId).delete();
  }

  /// ================================
  /// 🔹 SubCollection مرجع
  /// ================================
  CollectionReference<Map<String, dynamic>> _subCollection({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
  }) {
    return _collection(parentCollection).doc(parentDocId).collection(subCollection);
  }

  /// ================================
  /// ➕ إضافة داخل SubCollection
  /// ================================
  Future<String> addSubData({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required Map<String, dynamic> data,
  }) async {
    final docRef = _subCollection(
      parentCollection: parentCollection,
      parentDocId: parentDocId,
      subCollection: subCollection,
    ).doc();

    await docRef.set({...data, "id": docRef.id});

    return docRef.id;
  }

  /// ================================
  /// ✏️ تعديل داخل SubCollection
  /// ================================
  Future<void> updateSubData({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _subCollection(
      parentCollection: parentCollection,
      parentDocId: parentDocId,
      subCollection: subCollection,
    ).doc(docId).update(data);
  }

  /// ================================
  /// ❌ حذف داخل SubCollection
  /// ================================
  Future<void> deleteSubData({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required String docId,
  }) async {
    await _subCollection(
      parentCollection: parentCollection,
      parentDocId: parentDocId,
      subCollection: subCollection,
    ).doc(docId).delete();
  }

  /// ================================
  /// 📥 جلب كل عناصر SubCollection
  /// ================================
  Future<QuerySnapshot<Map<String, dynamic>>> getAllSubData({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
  }) async {
    return await _subCollection(
      parentCollection: parentCollection,
      parentDocId: parentDocId,
      subCollection: subCollection,
    ).get();
  }
}
