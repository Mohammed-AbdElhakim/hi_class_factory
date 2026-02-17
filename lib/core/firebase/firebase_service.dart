import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/app_strings.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /* =================================================
     1️⃣ تسجيل مستخدم جديد (Username + Password)
     ================================================= */
  Future<void> register({
    required String username,
    required String password,
    required String role,
    required String factoryId,
  }) async {
    final email = "$username${AppStrings.emailForm}";

    final usernameRef = _firestore.collection('usernames').doc(username);

    await _firestore.runTransaction((transaction) async {
      final snap = await transaction.get(usernameRef);

      if (snap.exists) {
        throw Exception('Username مستخدم قبل كده');
      }

      // إنشاء حساب Auth
      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // حجز الـ Username
      transaction.set(usernameRef, {'uid': userCred.user!.uid});

      // بيانات المستخدم
      transaction.set(
        _firestore.collection(AppStrings.collectionUsers).doc(userCred.user!.uid),
        {
          'uid': userCred.user!.uid,
          'username': username,
          'role': role,
          'createdAt': Timestamp.now(),
          'lastLogin': null,
          'lastLogout': null,
          'factoryId': factoryId,
        },
      );
    });
  }

  /* =================================================
     2️⃣ تسجيل دخول (Username + Password)
     ================================================= */
  Future<UserCredential> login({
    required String username,
    required String password,
  }) async {
    final email = "$username${AppStrings.emailForm}";

    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  /* =================================================
     3️⃣ إضافة بيانات لأي Collection
     ================================================= */
  Future<void> addData({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collection).add(data);
  }

  /* =================================================
     4️⃣ تعديل بيانات
     ================================================= */
  Future<void> updateData({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collection).doc(docId).update(data);
  }

  /* =================================================
     5️⃣ جلب بيانات عن طريق ID
     ================================================= */
  Future<DocumentSnapshot<Map<String, dynamic>>> getById({
    required String collection,
    required String docId,
  }) async {
    return await _firestore.collection(collection).doc(docId).get();
  }

  /* =================================================
     6️⃣ جلب كل البيانات
     ================================================= */
  Future<QuerySnapshot<Map<String, dynamic>>> getAll({required String collection}) async {
    return await _firestore.collection(collection).get();
  }

  /* =================================================
     7️⃣ حذف بيانات
     ================================================= */
  Future<void> delete({required String collection, required String docId}) async {
    await _firestore.collection(collection).doc(docId).delete();
  }

  /* =================================================
     8️⃣ تسجيل خروج
     ================================================= */
  Future<void> logout() async {
    await _auth.signOut();
  }

  /* =================================================
     9️⃣ المستخدم الحالي
     ================================================= */
  User? get currentUser => _auth.currentUser;

  /* =================================================
   إضافة بيانات داخل Subcollection
   ================================================= */
  Future<void> addSubData({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required Map<String, dynamic> data,
  }) async {
    final docRef = _firestore
        .collection(parentCollection)
        .doc(parentDocId)
        .collection(subCollection)
        .doc(); // auto ID
    final dataWithId = {...data, 'id': docRef.id};
    await docRef.set(dataWithId);
  }

  /* =================================================
   تعديل بيانات داخل Subcollection
   ================================================= */
  Future<void> updateSubData({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore
        .collection(parentCollection)
        .doc(parentDocId)
        .collection(subCollection)
        .doc(docId)
        .update(data);
  }

  /* =================================================
   حذف بيانات داخل Subcollection
   ================================================= */
  Future<void> deleteSubData({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required String docId,
  }) async {
    await _firestore
        .collection(parentCollection)
        .doc(parentDocId)
        .collection(subCollection)
        .doc(docId)
        .delete();
  }

  /* =================================================
   جلب كل البيانات من Subcollection
   ================================================= */
  Future<QuerySnapshot<Map<String, dynamic>>> getAllSubData({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
  }) async {
    return await _firestore
        .collection(parentCollection)
        .doc(parentDocId)
        .collection(subCollection)
        .get();
  }
}
