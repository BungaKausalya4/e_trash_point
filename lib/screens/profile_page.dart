import 'package:first_project/screens/ChangePasswordPage.dart';
import 'package:first_project/screens/EditProfilePage.dart';
import 'package:first_project/screens/FAQs.dart';
import 'package:first_project/screens/notificationPage.dart';
import 'package:first_project/screens/sharePage.dart';
import 'package:first_project/screens/welcome_screen.dart';
import 'package:first_project/theme/theme.dart';
import 'package:first_project/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = 'E-Trash Point';
  String _email = 'e-trashPoint@gmail.com';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: ExactAssetImage('assets/images/profile.png'),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: lightColorScheme.primary.withOpacity(.5),
                    width: 5.0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * .8, // Adjusted width
                child: Column(
                  children: [
                    Text(
                      _username,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _email,
                          style: TextStyle(
                            color: Colors.black.withOpacity(.3),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                          child: Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfilePage(username: _username, email: _email)),
                        );

                        // Update username and email if result is not null
                        if (result != null && result is Map<String, String>) {
                          setState(() {
                            _username = result['username']!;
                            _email = result['email']!;
                          });
                        }
                      },
                      child: ProfileWidget(
                        icon: Icons.person,
                        title: 'My Profile',
                      ),
                    ),
                    
                    GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordPage()),
    );
  },
  child: ProfileWidget(
    icon: Icons.lock,
    title: 'Change Password',
  ),
),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationPage()),
                        );
                      },
                      child: ProfileWidget(
                        icon: Icons.notifications,
                        title: 'Notifications',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FAQsPage()),
                        );
                      },
                      child: ProfileWidget(
                        icon: Icons.chat,
                        title: 'FAQs',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SharePage()), // Navigasi ke halaman SharePage
                        );
                      },
                      child: ProfileWidget(
                        icon: Icons.share,
                        title: 'Share',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to welcome screen when log out
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => WelcomeScreen()),
                        );
                      },
                      child: ProfileWidget(
                        icon: Icons.logout,
                        title: 'Log Out',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}