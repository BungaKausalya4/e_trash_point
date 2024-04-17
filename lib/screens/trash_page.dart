import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:first_project/theme/theme.dart';
import 'package:first_project/trash.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({Key? key}) : super(key: key);

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  int totalPoints = 0;
  int? selectedTrashId;

  List<DropdownMenuItem<int>> _buildDropdownMenuItems() {
    List<DropdownMenuItem<int>> items = [];
    for (var trash in Trash.trashList) {
      items.add(
        DropdownMenuItem(
          value: trash.trashId,
          child: Row(
            children: [
              Image.asset(
                trash.imageURL,
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Text(trash.trashName),
            ],
          ),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trash Page'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/b1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              color: Colors.black.withOpacity(0),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'TOTAL POINTS: $totalPoints',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<int>(
                    value: selectedTrashId,
                    items: _buildDropdownMenuItems(),
                    onChanged: (value) {
                      setState(() {
                        selectedTrashId = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select trash',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.lightGreen[100], // Warna hijau muda
                    ),
                    dropdownColor: Colors.lightGreen[100], // Warna hijau muda
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedTrashId != null) {
                        Trash exchangedTrash = exchangeTrashWithPoints(selectedTrashId!);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Success'),
                            content: Text('You have exchanged the trash for ${exchangedTrash.poin} points.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Please select a trash from the list.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: lightColorScheme.primary,
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      elevation: 4.0,
                    ),
                    child: Text(
                      'Exchange',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Trash exchangeTrashWithPoints(int trashId) {
    Trash foundTrash = Trash.trashList.firstWhere(
      (trash) => trash.trashId == trashId,
      orElse: () => Trash(
        trashId: -1,
        poin: 0,
        trashName: 'Unknown',
        imageURL: '',
        isSelected: false,
      ),
    );

    if (foundTrash.trashId != -1) {
      setState(() {
        foundTrash.isSelected = true;
        totalPoints += foundTrash.poin;
      });
    }

    return foundTrash;
  }
}
