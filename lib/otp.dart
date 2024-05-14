import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/screens/numericpad.dart';
import 'package:first_project/screens/root_page.dart';
import 'package:first_project/theme/theme.dart';
import 'package:flutter/material.dart';

class sms extends StatefulWidget {
  const sms({super.key});

  @override
  State<sms> createState() => _smsState();
}

class _smsState extends State<sms> {
  TextEditingController _codecontroller = new TextEditingController();
  String phoneNumber = "", data = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String smscode = "";

  _signInWithMobileNumber() async {
  UserCredential _credential;
  User user;
  String verificationId = "";

  try {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+62' + data.trim(),
      verificationCompleted: (PhoneAuthCredential authCredential) async {
        await _auth.signInWithCredential(authCredential).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RootPage()),
          );
        });
      },
      verificationFailed: (error) {
        print(error);
      },
      codeSent: (String id, [int? forceResendingToken]) {
        verificationId = id;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("Enter OTP"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _codecontroller,
                )
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  smscode = _codecontroller.text;
                  PhoneAuthCredential _credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: smscode,
                  );
                  auth.signInWithCredential(_credential).then((result) {
                    if (result != null) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RootPage()),
                      );
                    }
                  }).catchError((e) {
                    print(e);
                  });
                },
                child: Text("Ok"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Resend verification code
                  _auth.verifyPhoneNumber(
                    phoneNumber: '+62' + data.trim(),
                    verificationCompleted: (PhoneAuthCredential authCredential) async {
                      await _auth.signInWithCredential(authCredential).then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RootPage()),
                        );
                      });
                    },
                    verificationFailed: (error) {
                      print(error);
                    },
                    codeSent: (String id, [int? forceResendingToken]) {
                      verificationId = id;
                    },
                    codeAutoRetrievalTimeout: (String id) {
                      verificationId = id;
                    },
                    timeout: Duration(seconds: 45),
                  );
                },
                child: Text("Resend Code"),
              ),
            ],
          ),
        );
      },
      codeAutoRetrievalTimeout: (String id) {
        verificationId = id;
      },
      timeout: Duration(seconds: 45),
    );
  } catch (e) {
    print(e);
  }
}


  @override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      title: Text(
        "Continue with phone",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    body: SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFF7F7F7),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 180,
                    child: Image.asset('assets/images/holding-phone.png'),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 64),
                    child: Text(
                      "You'll receive a 6 digit code to verify next.",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF818181),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Enter your phone",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          phoneNumber,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        data = phoneNumber;
                        phoneNumber = "";

                        setState(() {});

                        _signInWithMobileNumber();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightColorScheme.primary.withOpacity(.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          NumericPad(
            onNumberSelected: (value) {
              setState(() {
                if (value != -1 && phoneNumber.length < 11) { // Batasi jumlah karakter
                  phoneNumber = phoneNumber + value.toString();
                } else if (value == -1) {
                  phoneNumber =
                      phoneNumber.substring(0, phoneNumber.length - 1);
                }
              });
            },
          ),
        ],
      ),
    ),
  );
}

}


