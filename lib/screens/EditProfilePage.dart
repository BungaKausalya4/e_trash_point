import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String username;
  final String email;

  const EditProfilePage({Key? key, required this.username, required this.email}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _usernameController.text = widget.username; 
    _emailController.text = widget.email; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              String newUsername = _usernameController.text;
              String newEmail = _emailController.text;
              Navigator.pop(context, {'username': newUsername, 'email': newEmail});
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
      ),
    );
  }
}
