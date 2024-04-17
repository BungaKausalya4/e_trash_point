import 'package:first_project/theme/theme.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          NotificationItem(
            title: 'Poin Bonus!',
            description: 'Anda telah mendapatkan 50 poin bonus untuk pengumpulan sampah minggu ini.',
            time: '2 hours ago',
          ),
          SizedBox(height: 16),
          NotificationItem(
            title: 'Hadiah Baru Tersedia',
            description: 'Tersedia hadiah-hadiah menarik yang bisa Anda tukarkan dengan poin Anda sekarang!',
            time: '1 day ago',
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;

  const NotificationItem({
    Key? key,
    required this.title,
    required this.description,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: lightColorScheme.primary),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description),
          SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      onTap: () {
      },
    );
  }
}
