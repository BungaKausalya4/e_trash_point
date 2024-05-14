import 'package:cloud_firestore/cloud_firestore.dart';

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
        .doc(id)
        .update({"Username": username, "Email": email, "Phone Number": phoneNumber, "Address": Address, "Gender": gender, "Password": password});
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


