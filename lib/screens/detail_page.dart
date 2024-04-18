import 'package:first_project/gift.dart';
import 'package:first_project/screens/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:first_project/theme/theme.dart';

class DetailPage extends StatefulWidget {
  final int giftId;
  const DetailPage({Key? key, required this.giftId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Gift> giftList = Gift.giftList;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: lightColorScheme.primary.withOpacity(.5),
                    ),
                    child: Icon(
                      Icons.close,
                      color: lightColorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 20,
                    right: -70,
                    child: SizedBox(
                      height: 350,
                      child: Image.asset(giftList[widget.giftId].imageURL),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GiftFeature(
                            title: 'Size',
                            giftFeature: giftList[widget.giftId].size,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              height: size.height * .4,
              width: size.width,
              decoration: BoxDecoration(
                color: lightColorScheme.primary.withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            giftList[widget.giftId].giftName,
                            style: TextStyle(
                              color: lightColorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${giftList[widget.giftId].poin} poin',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: size.width * .9,
        height: 50,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: giftList[widget.giftId].isSelected == true ? lightColorScheme.primary.withOpacity(.5) : Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    color: lightColorScheme.primary.withOpacity(.3),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    bool isSelected = toggleIsSelected(giftList[widget.giftId].isSelected);
                    giftList[widget.giftId].isSelected = isSelected;
                  });
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: giftList[widget.giftId].isSelected == true ? Colors.white : lightColorScheme.primary,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: lightColorScheme.primary.withOpacity(.3),
                    )
                  ],
                ),
                child: ElevatedButton(
  onPressed: () {
    
                          List<Gift> selectedGifts = giftList.where((gift) => gift.isSelected).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(addedToCartGifts: selectedGifts),
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
  ),
  child: Text(
    'REDEEM NOW',
    style: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    ),
  ),
),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GiftFeature extends StatelessWidget {
  final String giftFeature;
  final String title;
  const GiftFeature({
    Key? key,
    required this.giftFeature,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        Text(
          giftFeature,
          style: TextStyle(
            color: lightColorScheme.primary,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
