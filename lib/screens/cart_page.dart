// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/screens/database.dart';
import 'package:first_project/screens/voucher.dart';
import 'package:flutter/material.dart';
import 'package:first_project/theme/theme.dart';
import 'package:first_project/gift.dart';
import 'package:first_project/widgets/gift_widget.dart';

class CartPage extends StatefulWidget {
  final List<Gift> addedToCartGifts;
  const CartPage({Key? key, required this.addedToCartGifts}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _totalPoints = 0;
  List<String> _selectedGiftNames = [];
  int _userPoints = 0;

  DatabaseMethods db = DatabaseMethods();

  @override
  void initState() {
    super.initState();
    _calculateTotalPoints();
  }

  void _calculateTotalPoints() {
    int total = 0;
    List<String> selectedGiftNames = [];
    for (var gift in widget.addedToCartGifts) {
      total += gift.poin;
      if (gift.isSelected) {
        selectedGiftNames.add(gift.giftName);
      }
    }
    setState(() {
      _totalPoints = total;
      _selectedGiftNames = selectedGiftNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userId = db.getCurrentUserUid()!;

    db.getUserByUid(userId).then((value) {
      setState(() {
        _userPoints = value.data()!['points'];
      });
    });
    Size size = MediaQuery.of(context).size;
    _calculateTotalPoints();
    return Scaffold(
      body: widget.addedToCartGifts.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                    child: Icon(Icons.shopping_cart, size: 48),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Your Cart is Empty',
                    style: TextStyle(
                      color: lightColorScheme.primary,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              height: size.height,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.addedToCartGifts.length,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GiftWidget(
                              index: index, giftList: widget.addedToCartGifts);
                        }),
                  ),
                  Column(
                    children: [
                      const Divider(
                        thickness: 1.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  'Totals:',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: lightColorScheme.primary,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '$_totalPoints poin',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: lightColorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              

                              // if user doesnt have enough points
                              if (_userPoints < _totalPoints) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.green,
                                    title: Text(
                                      'Cari Sampah Lagi!!',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                      'You don\'t have enough points to redeem the gift.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'OK',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }

                              _updateUserPoints(userId, _totalPoints);

                              // clear the cart
                              widget.addedToCartGifts.clear();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VoucherCard(
                                    logoAsset: 'assets/images/logo.png',
                                    voucherTitle: 'E-Trash Point',
                                    voucherCode: 'ABCDE12345',
                                    rewardName: _selectedGiftNames.isNotEmpty
                                        ? _selectedGiftNames.join(', ')
                                        : '', // Menggabungkan semua nama hadiah yang dipilih menjadi satu teks
                                    checkoutDate: DateTime.now(),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.green,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart),
                                SizedBox(width: 8),
                                Text(
                                  'Checkout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  // subtract users['points'] with _totalPoints
  void _updateUserPoints(String userId, int totalPoints) {
    FirebaseFirestore.instance.collection('users').doc(userId).update({
      'points': FieldValue.increment(-totalPoints),
    });

    for (var gift in widget.addedToCartGifts) {
      print("Hello ${gift.isSelected}");
      if (gift.isSelected) {
        Map<String, dynamic> transactionMap = {
          'transactionId': DateTime.now().millisecondsSinceEpoch,
          'points': gift.poin,
          'timestamp': DateTime.now(),
          'type': 'gift',
          'giftId': gift.giftId,
        };
        _addTransactionToUser(userId, transactionMap);
      }
    }
  }

  // add transaction to user collection
  void _addTransactionToUser(
      String userId, Map<String, dynamic> transactionMap) {
    db.addTransactionToUser(userId, transactionMap);
  }
}
