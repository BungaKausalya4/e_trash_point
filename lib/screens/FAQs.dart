import 'package:first_project/theme/theme.dart';
import 'package:flutter/material.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FAQItem(
              question: 'Bagaimana cara mendapatkan poin?',
              answer: 'Untuk mendapatkan poin di e-trash point, Anda dapat menukarkan sampah yang Anda kumpulkan dengan timbangan yang ada di lokasi e-trash point atau dengan cara mengunggah bukti foto pengumpulan sampah Anda ke dalam aplikasi.',
            ),
            SizedBox(height: 16),
            FAQItem(
              question: 'Apakah ada batasan jumlah sampah yang dapat ditukarkan?',
              answer: 'Ya, ada kemungkinan ada batasan jumlah sampah yang bisa ditukarkan dalam satu transaksi. Batasan ini dapat berbeda-beda tergantung pada kebijakan e-trash point di lokasi tertentu.',
            ),
            SizedBox(height: 16),
            FAQItem(
              question: 'Apakah saya bisa mentransfer poin saya ke akun e-trash point lain?',
              answer: 'Saat ini, kemungkinan transfer poin antar akun e-trash point tidak tersedia. Namun, Anda dapat menggunakan poin yang Anda kumpulkan untuk menukar hadiah di akun Anda sendiri.',
            ),
            SizedBox(height: 16),
            FAQItem(
              question: 'Bagaimana cara saya menghubungi layanan pelanggan jika saya memiliki masalah dengan aplikasi atau transaksi saya?', 
              answer: 'Anda dapat menghubungi layanan pelanggan e-trash point melalui email atau nomor telepon yang tercantum di dalam aplikasi untuk bantuan jika Anda mengalami masalah dengan aplikasi atau transaksi Anda.',
            ),
            SizedBox(height: 16),
            FAQItem(
              question: 'Apakah e-trash point memiliki kebijakan privasi yang melindungi informasi pribadi saya?',
              answer: 'Ya, e-trash point memiliki kebijakan privasi yang melindungi informasi pribadi pengguna. Informasi lebih lanjut tentang kebijakan privasi e-trash point dapat ditemukan di dalam aplikasi atau situs web mereka.',
            ),
            // Tambahkan pertanyaan dan jawaban FAQs lainnya di sini
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              widget.question,
              style: TextStyle(fontWeight: FontWeight.bold, color: lightColorScheme.primary),
            ),
          ),
        ),
        if (_expanded)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(widget.answer),
          ),
        Divider(),
      ],
    );
  }
}
