import 'package:first_project/screens/database.dart';
import 'package:first_project/screens/detail_page.dart';
import 'package:first_project/screens/infoTrash.dart';
import 'package:first_project/screens/maps.dart';
import 'package:first_project/screens/profile_page.dart';
import 'package:first_project/screens/trash_page.dart';
import 'package:flutter/material.dart';
import 'package:first_project/screens/cart_page.dart';
import 'package:first_project/screens/historyPage.dart'; 
import 'package:first_project/theme/theme.dart';
import 'package:first_project/gift.dart';
import 'package:first_project/trash.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalPoints = 0;
  String searchText = '';

  DatabaseMethods db = DatabaseMethods();



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Gift> giftList = Gift.giftList;
    List<Trash> trashList = Trash.trashList;

    bool toggleIsSelected(bool isSelected) {
      return !isSelected;
    }
    List<String> menuItems = [
  'Cart',
  'Maps',
  'Profile',
  'Trash',
  'History',
  'More',
];

List<int> filteredIndexes = List.generate(menuItems.length, (index) => index)
    .where((index) => menuItems[index].toLowerCase().contains(searchText.toLowerCase()))
    .toList();

    String userId = db.getCurrentUserUid()!;

    db.getUserByUid(userId).then((value) {
      setState(() {
        totalPoints = value.data()!['points'];
      });
    });



    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    width: size.width * .9,
                    decoration: BoxDecoration(
                      color: lightColorScheme.primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black54.withOpacity(.6),
                        ),
                        Expanded(
  child: TextField(
    onChanged: (value) {
      setState(() {
        searchText = value;
      });
    },
    showCursor: false,
    decoration: InputDecoration(
      hintText: 'Search..',
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
    ),
  ),
),

                        Icon(
                          Icons.mic,
                          color: Colors.black54.withOpacity(.6),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.point_of_sale,
                  color: lightColorScheme.primary,
                ),
                SizedBox(width: 5),
                Text(
                  'Total Points: $totalPoints',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: lightColorScheme.primary,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.apps,
                        size: 24,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'MENU',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
           Container(
          color: lightColorScheme.primary.withOpacity(.2),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: GridView.builder(
            itemCount: filteredIndexes.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.1,
            ),
                
                itemBuilder: (context, index) {
                  IconData iconData;
                  String itemName;
                  switch (index) {
                    case 0:
                      iconData = Icons.shopping_cart;
                      itemName = 'Cart';
                      break;
                    case 1:
                      iconData = Icons.map;
                      itemName = 'Maps';
                      break;
                    case 2:
                      iconData = Icons.person;
                      itemName = 'Profile';
                      break;
                    case 3:
                      iconData = Icons.delete;
                      itemName = 'Trash';
                      break;
                    case 4:
                      iconData = Icons.history;
                      itemName = 'History';
                      break;
                    default:
                      iconData = Icons.more_horiz;
                      itemName = 'More';
                      break;
                  }
                  return GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          List<Gift> selectedGifts = giftList.where((gift) => gift.isSelected).toList();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(addedToCartGifts: selectedGifts),
                            ),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapAppBar(),
                            ),
                          );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                          break;
                        case 3:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrashPage(userId: '',),
                            ),
                          );
                          break;
                        case 4:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryPage(giftId: '', email: '',),
                            ),
                          );
                          break;
                        default:
                          break;
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: lightColorScheme.primary.withOpacity(.5),
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Icon(iconData)),
                        ),
                        SizedBox(height: 10),
                        Text(
                          itemName,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(.7)),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.card_giftcard,
                    size: 24,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'GIFT',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .3,
              child: ListView.builder(
                itemCount: giftList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: DetailPage(
                            giftId: giftList[index].giftId,
                          ),
                          type: PageTransitionType.bottomToTop,
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: lightColorScheme.primary.withOpacity(.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            right: 20,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    bool isSelected = toggleIsSelected(giftList[index].isSelected);
                                    giftList[index].isSelected = isSelected;
                                  });
                                },
                                icon: Icon(
                                  giftList[index].isSelected == true
                                      ? Icons.shopping_cart
                                      : Icons.shopping_cart_outlined,
                                  color: lightColorScheme.primary,
                                ),
                                iconSize: 30,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Text(
                                giftList[index].giftName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            right: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${giftList[index].poin} poin',
                                style: TextStyle(
                                  color: lightColorScheme.primary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 20,
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.asset(giftList[index].imageURL),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    size: 24,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'TRASH',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: size.height * .5,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
    // Navigasi ke TrashDetailPage dengan memberikan detail trash yang diklik
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrashDetailPage(trash: trashList[index]),
      ),
    );
  },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: lightColorScheme.primary.withOpacity(.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.asset(trashList[index % trashList.length].imageURL),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trashList[index % trashList.length].trashName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${trashList[index].poin} poin',
                                    style: TextStyle(
                                      color: lightColorScheme.primary,
                                      fontSize: 16,
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
