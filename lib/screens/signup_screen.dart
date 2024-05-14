import 'package:firebase_database/firebase_database.dart';
import 'package:first_project/screens/database.dart';
import 'package:first_project/screens/root_page.dart';
import 'package:first_project/screens/signin_screen.dart';
import 'package:first_project/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:first_project/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignUpKey = GlobalKey<FormState>();
  bool agreePersonalData = true;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String _password = '', username="", email="", confirm_pass="", phoneNumber="";
  bool? gender; 


  TextEditingController usernamecontroller= new TextEditingController();
  TextEditingController emailcontroller= new TextEditingController();
  TextEditingController passwordcontroller= new TextEditingController();
  TextEditingController confirmpasswordcontroller= new TextEditingController();
  TextEditingController phoneNumbercontroller= new TextEditingController();
  TextEditingController addresscontroller= new TextEditingController();
  TextEditingController gendercontroller= new TextEditingController();
  final databaseReference = FirebaseDatabase.instance.ref("StoreData");



    registration() async {
  // Define your registration map correctly
  Map<String, dynamic> registration = {
    'username': usernamecontroller.text,
    'email': emailcontroller.text,
    'Phone Number': phoneNumbercontroller.text,
    'Address': addresscontroller.text,
    'Password': passwordcontroller.text,
    'Gender': gender == true ? 'Male' : 'Female',
  };

  if (_password.isNotEmpty &&
      usernamecontroller.text.isNotEmpty &&
      emailcontroller.text.isNotEmpty) {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: _password.trim(),
      );
      
      // Use userCredential for further operations (e.g., accessing user details)
      User? user = userCredential.user;
      
      // Continue with other logic (e.g., showing success message, navigation)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Registered Successfully: ${user?.email}",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );
      // Navigate to the root page upon successful registration
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RootPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: lightColorScheme.primary,
            content: Text(
              "Password Provided is too Weak",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: lightColorScheme.primary,
            content: Text(
              "Account Already Exists",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    } catch (e) {
      // Handle other exceptions
      print("Error: $e");
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Please provide all required information",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  // Call addUserDetails from DatabaseMethods with registration map
  await DatabaseMethods().addUserDetails(registration);

  Fluttertoast.showToast(
    msg: "Data Uploaded Successfully",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: lightColorScheme.primary,
    textColor: Colors.white,
    fontSize: 16.0,
  );

  
}

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignUpKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started!',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: 'Enter Email',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: usernamecontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Username';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Username'),
                          hintText: 'Enter Username',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: phoneNumbercontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Phone Number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Phone Number'),
                          hintText: 'Enter Phone Number',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      
                       const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<bool>(
  value: gender,
  onChanged: (newValue) {
    setState(() {
      gender = newValue;
    });
  },
  validator: (value) {
    if (value == null) {
      return 'Please select your gender';
    }
    return null;
  },
  decoration: InputDecoration(
    labelText: 'Gender',
    hintText: 'Select Gender',
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black12),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black12),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  items: [
    DropdownMenuItem<bool>(
      value: true,
      child: Text('Male'),
    ),
    DropdownMenuItem<bool>(
      value: false,
      child: Text('Female'),
    ),
  ],
),

                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: addresscontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Address'),
                          hintText: 'Enter Address',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        obscureText: !_showPassword,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black26,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        obscureText: !_showConfirmPassword,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Confirm Password';
                          } else if (value != _password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Confirm Password'),
                          hintText: 'Enter Confirm Password',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black26,
                            ),
                            onPressed: () {
                              setState(() {
                                _showConfirmPassword = !_showConfirmPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
  onPressed: () {
    
    if (_formSignUpKey.currentState!.validate() && agreePersonalData) {
      registration(); // Panggil fungsi registration() jika formulir valid dan setuju pada data pribadi
    } else if (!agreePersonalData) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please agree to the processing of personal data'),
        ),
      );
    }
    databaseReference.child("users").push().set({
          'username': usernamecontroller.text.toString(),
                'address': addresscontroller.text.toString(),
                'email': emailcontroller.text.toString(),
                'password': passwordcontroller.text.toString(),
                'id': DateTime.now()
                    .microsecond
                    .toString(),
        });
  },
  style: ElevatedButton.styleFrom(
    primary: lightColorScheme.primary,
    onPrimary: Colors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: EdgeInsets.symmetric(vertical: 15),
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    animationDuration: Duration(milliseconds: 300),
  ),
  child: Ink(
    child: Container(
      alignment: Alignment.center,
      child: Text('Sign Up'),
    ),
  ),
),

                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      
                     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have an account? ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              
          
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => const SignInScreen()),
                              );
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Color.fromARGB(255, 66, 201, 111),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}