import 'package:first_project/theme/theme.dart';
import 'package:flutter/material.dart';

class VoucherCard extends StatelessWidget {
  final String logoAsset;
  final String voucherTitle;
  final String voucherCode;
  final String rewardName;
  final DateTime checkoutDate;

  const VoucherCard({
    Key? key,
    required this.logoAsset,
    required this.voucherTitle,
    required this.voucherCode,
    required this.rewardName,
    required this.checkoutDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime validUntil = checkoutDate.add(Duration(days: 6));

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(168, 255, 171, 1),
              Color.fromRGBO(62, 158, 66, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(), // Hindari overflow dengan membatasi guliran
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                        // Tambahkan logika penanganan ketika tombol close ditekan di sini
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'E-Trash Point',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'VOUCHER KLAIM HADIAH',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: lightColorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Kode Voucher: $voucherCode',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: MediaQuery.of(context).size.width * 0.8, // Sesuaikan lebar gambar dengan lebar layar
                        height: MediaQuery.of(context).size.width * 0.8,
                      ),
                      Text(
                        rewardName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Text(
                  'Berlaku hingga: ${validUntil.day} ${_getMonthName(validUntil.month)} ${validUntil.year}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }
}
