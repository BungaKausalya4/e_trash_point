import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  static List<String> purchaseHistory = []; // List untuk menyimpan riwayat pembelian

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
      ),
      body: purchaseHistory.isEmpty
          ? Center(
              child: Text('Your purchase history will be displayed here.'),
            )
          : ListView.builder(
              itemCount: purchaseHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(purchaseHistory[index]),
                );
              },
            ),
    );
  }
}
