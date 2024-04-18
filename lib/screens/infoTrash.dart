
import 'package:first_project/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:first_project/trash.dart';

class TrashDetailPage extends StatefulWidget {
  final Trash trash;

  const TrashDetailPage({Key? key, required this.trash}) : super(key: key);

  @override
  _TrashDetailPageState createState() => _TrashDetailPageState();
}

class _TrashDetailPageState extends State<TrashDetailPage> {
  bool isFlipped = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('About Trash'),
        backgroundColor: Colors.green.shade200,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade200, // Warna transparan
              Color.fromARGB(255, 33, 143, 48), // Warna hijau dengan opacity
            ],
          ),
        ),
        child: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isFlipped = !isFlipped;
              });
            },
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 15,
                    offset: Offset(0, 3),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.8), // Warna transparan
                    Colors.green.withOpacity(0.8), // Warna hijau dengan opacity
                  ],
                ),
              ),
              child: Stack(
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: isFlipped ? 0.0 : 1.0,
                    child: buildFrontContent(),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: isFlipped ? 1.0 : 0.0,
                    child: buildBackContent(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFrontContent() {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 240, // Lebar kontainer gambar
            height: 240, // Tinggi kontainer gambar
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Radius sudut yang lebih besar
              child: Image.asset(
                widget.trash.imageURL,
                fit: BoxFit.contain, // Menyesuaikan gambar proporsional di dalam ClipRRect
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            widget.trash.trashName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${widget.trash.poin} poin',
            style: TextStyle(
              fontSize: 18,
              color: const Color.fromARGB(255, 52, 126, 23),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 100),
          Text(
            'Tap to see description',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget buildBackContent() {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Description:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: lightColorScheme.primary,
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.trash.description,
            textAlign: TextAlign.justify, // Align text to justify (left and right)
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}

}
