import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_project/screens/ChangePasswordPage.dart';
import 'package:first_project/screens/EditProfilePage.dart';
import 'package:first_project/screens/FAQs.dart';
import 'package:first_project/screens/database.dart';
import 'package:first_project/screens/notificationPage.dart';
import 'package:first_project/screens/sharePage.dart';
import 'package:first_project/screens/welcome_screen.dart';
import 'package:first_project/theme/theme.dart';
import 'package:first_project/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = '';
  String _email = '';
  String imageUrl = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Panggil method untuk mengambil informasi pengguna saat initState
    _getUserInfo();
  }

  void _getUserInfo() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Set nilai _username dan _email berdasarkan informasi pengguna yang terautentikasi
        setState(() {
          _username =
              user.displayName ?? ''; // Gunakan displayName jika tersedia
          _email = user.email ?? '';
        });
      }
    } catch (e) {
      print('Error getting user info: $e');
    }
  }

  void _signOut() async {
    try {
      await _auth.signOut();
      // Navigasi ke halaman welcome screen setelah logout
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  DatabaseMethods db = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: db.getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var data = snapshot.data as dynamic;

          final storageRef = FirebaseStorage.instance.ref();
          final imageRef = storageRef.child('images/${data['email']}.jpg');

          imageRef.getDownloadURL().then((value) => {imageUrl = value});

          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                height: size.height,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: lightColorScheme.primary.withOpacity(.5),
                          width: 5.0,
                        ),
                      ),
                      child: Stack(
                        children: [
                          ClipOval(
                            child: imageUrl.isNotEmpty
                                ? Image.network(
                                    // ambil database dari storage firebase
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  )
                                : Image.asset(
                                    'assets/images/profile.png',
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: lightColorScheme
                                    .primary, // Background color
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  // Step 1: Pick image from camera or gallery
                                  final ImagePicker imagePicker = ImagePicker();
                                  final XFile? file =
                                      await showModalBottomSheet<XFile>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Wrap(
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(Icons.photo_library),
                                            title: Text('Photo Library'),
                                            onTap: () async {
                                              Navigator.pop(
                                                  context,
                                                  await imagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery));
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.photo_camera),
                                            title: Text('Camera'),
                                            onTap: () async {
                                              Navigator.pop(
                                                  context,
                                                  await imagePicker.pickImage(
                                                      source:
                                                          ImageSource.camera));
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (file == null) return;

                                  // Step 2: Upload to Firebase Storage
                                  try {
                                    String uniqueFileName = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
                                    Reference referenceRoot =
                                        FirebaseStorage.instance.ref();
                                    Reference referenceDirImages =
                                        referenceRoot.child('images');
                                    Reference referenceImageToUpload =
                                        referenceDirImages
                                            .child(data['email'] + '.jpg');

                                    await referenceImageToUpload
                                        .putFile(File(file.path));

                                    // Step 3: Get the download URL
                                    imageUrl = await referenceImageToUpload
                                        .getDownloadURL();

                                    setState(() {
                                      // Update the UI to display the uploaded image
                                      imageUrl = imageUrl;
                                    });
                                  } catch (error) {
                                    print('Error uploading image: $error');
                                  }
                                },
                                icon: Icon(Icons.add_a_photo),
                                iconSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .8, // Adjusted width
                      child: Column(
                        children: [
                          Text(
                            data['username']!,
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
                                MaterialPageRoute(
                                    builder: (context) => EditProfilePage(
                                        username: _username, email: _email)),
                              );

                              // Update username and email if result is not null
                              if (result != null) {
                                setState(() {
                                  _username = data['username']!;
                                  _email = data['email']!;
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
                                MaterialPageRoute(
                                    builder: (context) => ChangePasswordPage()),
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
                                MaterialPageRoute(
                                    builder: (context) => NotificationPage()),
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
                                MaterialPageRoute(
                                    builder: (context) => FAQsPage()),
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
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SharePage()), // Navigasi ke halaman SharePage
                              );
                            },
                            child: ProfileWidget(
                              icon: Icons.share,
                              title: 'Share',
                            ),
                          ),
                          GestureDetector(
                            onTap: _signOut,
                            child: const ProfileWidget(
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
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
