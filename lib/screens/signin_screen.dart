import 'package:first_project/screens/ResetPasswordScreen.dart';
import 'package:first_project/screens/root_page.dart';
import 'package:first_project/screens/signup_screen.dart';
import 'package:first_project/theme/theme.dart';
import 'package:first_project/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool rememberPassword = true;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

@override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _usernameController.dispose();
    _passwordController.dispose();
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
                        controller: _usernameController,
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
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
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
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberPassword,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberPassword = value!;
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Forget Password?'),
          content: const Text('Please enter your email to reset your password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResetPasswordScreen(),
                  ),
                );
              },
              child: const Text('Reset Password'),
            ),
          ],
        );
      },
    );
  },
  child: Text(
    'Forget password?',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: lightColorScheme.primary,
    ),
  ),
),

                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      SizedBox(
  width: double.infinity,
  child: ElevatedButton(
  onPressed: () {
    if (_formSignInKey.currentState!.validate() && rememberPassword) {
      String username = 'E-Trash Point';
      String password = 'etrashpoint';
      if (_usernameController.text == username && _passwordController.text == password) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign in successful'),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RootPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password'),
          ),
        );
      }
    } else if (!rememberPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please remember your password'),
        ),
      );
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
  child: Ink(
    child: Container(
      alignment: Alignment.center,
      child: Text('Sign In'),
    ),
  ),
),
),

                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
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
                          SvgPicture.asset(
                            'assets/images/google_logo.svg',
                            width: 32,
                            height: 32,
                          ),
                          SvgPicture.asset(
                            'assets/images/facebook_logo.svg',
                            width: 32,
                            height: 32,
                          ),
                          SvgPicture.asset(
                            'assets/images/instagram_logo.svg',
                            width: 32,
                            height: 32,
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
                                MaterialPageRoute(builder: (e) => const SignUpScreen()),
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
