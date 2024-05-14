// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    print("Adding user details to database...");
    print("User Info: $userInfoMap");
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(getCurrentUserUid())
        .set(userInfoMap);
  }

  Stream<QuerySnapshot> getThisUserInfo(String username) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots();
  }

  // get user from database collection using uid
  Future getUserByUid(String uid) async {
    return await FirebaseFirestore.instance.collection("users").doc(uid).get();
  }

  Future updateUserData(String username, String email, String phoneNumber,
      String id, String address, bool gender, String password) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(getCurrentUserUid())
        .update({
      "Username": username,
      "Email": email,
      "Phone Number": phoneNumber,
      "Address": address,
      "Gender": gender,
      "Password": password,
    });
  }

  // add to user collection and make new collection transaction
  Future addTransactionToUser(String uid, Map<String, dynamic> transactionMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("transactions")
        .add({
      "transactionId": transactionMap["transactionId"],
      "points": transactionMap["points"],
      "timestamp": transactionMap["timestamp"],
      "type": transactionMap["type"],
    });
  }

  // get all transactions from user
  Stream<QuerySnapshot> getTransactions() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(getCurrentUserUid())
        .collection("transactions")
        .snapshots();
  }


  // add transaction table to database
  Future addTransaction(Map<String, dynamic> transactionMap) async {
    return await FirebaseFirestore.instance
        .collection("transactions")
        .doc()
        .set(transactionMap);
  }

  String? getCurrentUserUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future UpdateUserDetail(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update(updateInfo);
  }

  Future<Stream<QuerySnapshot>> getUserdetail() async {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }

  Future DeleteUserData(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .delete();
  }
}
