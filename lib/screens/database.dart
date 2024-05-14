import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  
  Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc()
        .set(userInfoMap);
  }

  Stream<QuerySnapshot> getthisUserInfo(String username) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots();
  }

  Future UpdateUserData(String username, String email, String phoneNumber, String id, String Address, bool gender, String password) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(getCurrentUserUid())
        .update({
      "Username": username,
      "Email": email,
      "Phone Number": phoneNumber,
      "Address": Address,
      "Gender": gender,
      "Password": password,
      "userPoints": 0,
    });
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
    return await FirebaseFirestore.instance
        .collection("users")
        .snapshots();
  }

Future DeleteUserData(String id)async{
  return await FirebaseFirestore.instance.collection("users").doc(id).delete();
}


}


