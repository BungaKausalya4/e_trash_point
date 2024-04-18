import 'package:first_project/screens/detail_page.dart';
import 'package:first_project/theme/theme.dart';
import 'package:first_project/gift.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class GiftWidget extends StatelessWidget {
  const GiftWidget({
    Key? key, required this.index, required this.giftList,
  }) : super(key: key);

  final int index;
  final List<Gift> giftList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: DetailPage(
                  giftId: giftList[index].giftId,
                ),
                type: PageTransitionType.bottomToTop));
      },
      child: Container(
        decoration: BoxDecoration(
          color: lightColorScheme.primary.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80.0,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        width: size.width,
        child: Row(
  children: [
    Stack(
      clipBehavior: Clip.none,
      children: [
        ClipOval(
          child: Container(
            width: 60.0,
            height: 60.0,
            color: lightColorScheme.primary.withOpacity(.8),
            child: Image.asset(
              giftList[index].imageURL,
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 60.0 + 8.0, 
          child: Text(
            giftList[index].giftName,
            style: TextStyle(
              fontSize: 18.0,
              color: lightColorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    SizedBox(width: 16.0),
    Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          '${giftList[index].poin} poin', 
          style: TextStyle(
            fontSize: 18.0,
            color: lightColorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ],
),


      )
    );
  }
}