import 'package:first_project/theme/theme.dart';
import 'package:flutter/material.dart';

class MapAppBar extends StatefulWidget {
  final VoidCallback? onMapButtonPressed;

  const MapAppBar({Key? key, this.onMapButtonPressed}) : super(key: key);

  @override
  _MapAppBarState createState() => _MapAppBarState();
}

class _MapAppBarState extends State<MapAppBar> {
  bool _showBranches = false;
  int _selectedBranchIndex = -1;

  Map<String, String> branchImagePaths = {
    'Gubeng': 'assets/images/GB.jpg',
    'Gunung Anyar': 'assets/images/GA.jpg',
    'Sukolilo': 'assets/images/SL.jpg',
    'Tambaksari': 'assets/images/MG.jpg',
    'Mulyorejo': 'assets/images/MJ.jpg',
    'Rungkut': 'assets/images/RT.jpg',
    'Tenggilis Mejoyo': 'assets/images/TM.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.indigo],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  _selectedBranchIndex != -1
                      ? branchImagePaths.values.toList()[_selectedBranchIndex]
                      : 'assets/images/maps.jpeg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                ),
                Positioned(
                  top: 20.0,
                  left: 10.0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showBranches = !_showBranches;
              });
              if (widget.onMapButtonPressed != null) {
                widget.onMapButtonPressed!();
              }
            },
            style: ElevatedButton.styleFrom(
              primary: lightColorScheme.primary,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              shadowColor: Colors.black.withOpacity(0.3),
              elevation: 5,
            ),
            child: Text(
              _showBranches ? 'Sembunyikan Daftar Cabang' : 'Lihat Daftar Cabang',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          if (_showBranches)
            Expanded(
              child: ListView.builder(
                itemCount: branchImagePaths.length,
                itemBuilder: (context, index) {
                  List<String> branches = branchImagePaths.keys.toList();
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    elevation: 3,
                    color: Color.fromARGB(255, 146, 255, 103).withOpacity(.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: Text(
                        branches[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Surabaya'),
                      trailing: Icon(Icons.location_on),
                      onTap: () {
                        setState(() {
                          _selectedBranchIndex = index;
                        });
                        print('${branches[index]} di-klik');
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
