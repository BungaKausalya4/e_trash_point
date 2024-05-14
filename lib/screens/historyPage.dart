import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/screens/database.dart';
import 'package:first_project/theme/theme.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  final String giftId;
  final String email;

  const HistoryPage({Key? key, required this.giftId, required this.email}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  TextEditingController _giftIdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Stream? UserStream;

  getontheload() async {
    UserStream = await DatabaseMethods().getUserdetail();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allUserDetails() {
  return StreamBuilder(
    stream: UserStream,
    builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData
          ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: lightColorScheme.primary.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  _giftIdController.text = ds["giftId"];
                                  _emailController.text = ds["email"];
                                  EditUserDetail(ds.id);
                                },
                                child: Icon(Icons.edit, color: lightColorScheme.primary),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await DatabaseMethods().DeleteUserData(ds.id);
                                },
                                child: Icon(Icons.delete, color: lightColorScheme.primary),
                              ),
                            ],
                          ),
                          SizedBox(height: 10), // Add spacing between giftId and text fields
                          TextFormField(
                            controller: TextEditingController(text: ds["giftId"]),
                            decoration: InputDecoration(
                              labelText: 'giftId',
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true, // Prevent editing
                          ),
                          SizedBox(height: 10), // Add spacing between giftId and text fields
                          TextFormField(
                            controller: TextEditingController(text: ds["email"]),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true, // Prevent editing
                          ),
                          
                          // Add more TextFormField widgets for other user details if needed
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Container();
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(
              child: allUserDetails(),
            ),
          ],
        ),
      ),
    );
  }

  Future EditUserDetail(String id) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    content: Container(
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel),
              ),
              Text(
                "Edit",
                style: TextStyle(
                  color: lightColorScheme.primary,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Details",
                style: TextStyle(
                  color: Color.fromARGB(255, 105, 201, 67),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            "giftId",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _giftIdController,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            "Email",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          SizedBox(height: 30.0),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                Map<String, dynamic>updateInfo={
                  "giftId": _giftIdController.text,
                "email": _emailController.text,
                "id": id,
                };
                // Update user data in Firestore
                await DatabaseMethods().UpdateUserDetail(id, updateInfo).then((value){});
                 Navigator.pop(context);
                ;
              },
              child: Text("Update"),
            ),
          ),
        ],
      ),
    ),
  ),
);


}
