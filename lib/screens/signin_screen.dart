import 'package:first_project/otp.dart';
import 'package:first_project/screens/ResetPasswordScreen.dart';
import 'package:first_project/screens/root_page.dart';
import 'package:first_project/screens/signup_screen.dart';
import 'package:first_project/theme/theme.dart';
import 'package:first_project/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String email = "";
  String password = "";
  bool _showPassword = false;
  bool rememberPassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

Future<UserCredential> signInWithGithub() async {
  GithubAuthProvider githubAuthProvider =GithubAuthProvider();

  try {
    return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
  } catch (e) {
     print("");
     rethrow;
  }
 
  
  
}
void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // Navigate to home or root page after successful sign-in
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RootPage()),
          );
        } else {
          // Handle sign-in failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to sign in with Google.'),
            ),
          );
        }
      } else {
        // Google sign-in canceled by user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google sign-in canceled.'),
          ),
        );
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing in with Google.'),
        ),
      );
    }
  }
  void userSignIn() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RootPage()),
    );
  } on FirebaseAuthException catch (e) {
    String errorMessage = 'The password/email for this user is incorrect.';
    
    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided for this user.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 70, 172, 30),
        content: Text(
          errorMessage,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  } catch (e) {
    print('Error signing in: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Sign in failed. Please try again later.',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}


  @override
  void dispose() {
    emailController.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
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
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome back!',
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
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'email',
                          hintText: 'Enter email',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
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
                        controller: confirmpasswordcontroller,
                        obscureText: !_showPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberPassword,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberPassword = value ?? false;
                                  });
                                },
                                activeColor: lightColorScheme.primary,
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
    );
  },
  child: Text(
    "Forgot Password?",
    style: TextStyle(
      color: Color(0xFF8c8e98),
      fontSize: 13.0, // Ubah ukuran font ke 16
      fontWeight: FontWeight.w500,
    ),
  ),
),

                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formSignInKey.currentState!.validate()) {
                              setState(() {
                                email = emailController.text;
                                password = confirmpasswordcontroller.text;
                              });
                              userSignIn();
                            }
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
                          child: Text('Sign In'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sign In with',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        
                          GestureDetector(
              onTap: signInWithGoogle,
              child: SvgPicture.asset(
                'assets/images/google_logo.svg',
                width: 32,
                height: 32,
              ),
            ),
                          GestureDetector(
  onTap: () {
    // Navigasi ke kelas SMS
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => sms()), // Ganti SmsScreen dengan nama kelas yang sesuai
    );
  },
  child: Icon(
    Icons.message, // Gunakan ikon pesan atau ikon lain yang sesuai
    size: 32,
    color: Colors.black, // Ubah warna ikon sesuai kebutuhan
  ),
),
GestureDetector(
  onTap: () async {
    try {
      UserCredential userCredential = await signInWithGithub();
        
      if (context.mounted) {
        // Navigasi hanya dilakukan jika berhasil masuk

        print("Successfull");


      }

              Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RootPage(),
          ),
        );
    } catch (e) {
      // Tangani kesalahan yang terjadi selama proses masuk
      print('Error signing in with GitHub: $e');
      // Anda mungkin ingin menampilkan pesan kesalahan kepada pengguna di sini
    }
  },
  child: Image.asset(
    'assets/images/github_logo.png',
    width: 32,
    height: 32,
  ),
),


                          
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color.fromARGB(255, 66, 201, 111),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
