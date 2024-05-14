import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:first_project/gift.dart';
import 'package:first_project/screens/home_page.dart';
import 'package:first_project/screens/maps.dart';
import 'package:first_project/screens/profile_page.dart';
import 'package:first_project/screens/cart_page.dart';
import 'package:first_project/screens/trash_page.dart';
import 'package:first_project/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Gift> myCart = [];
  bool _notificationEnabled = true; 

  int _bottomNavIndex = 0;

  // List of the pages
  List<Widget> _widgetOptions() {
    return [
      const HomePage(),
      MapAppBar(onMapButtonPressed: onMapButtonPressed),
      CartPage(addedToCartGifts: myCart,),
      const ProfilePage(),
    ];
  }

  // List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.map,
    Icons.shopping_cart,
    Icons.person,
  ];

  // List of the pages titles
  List<String> titleList = [
    'Home',
    'Map',
    'Cart',
    'Profile',
  ];

  void onMapButtonPressed() {
    // Implement your logic here
    print('Map button pressed');
  }

  // Function to toggle notification
  void toggleNotification() {
    setState(() {
      _notificationEnabled = !_notificationEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      appBar: AppBar(
        shadowColor: lightColorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleList[_bottomNavIndex],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            GestureDetector( 
              onTap: toggleNotification, 
              child: Icon( 
                _notificationEnabled ? Icons.notifications : Icons.notifications_off,
                color: _notificationEnabled ? Colors.black : Colors.grey,
                size: 30.0,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, PageTransition(child: const TrashPage(userId: '',), type: PageTransitionType.bottomToTop));
        },
        child: Image.asset('assets/images/trash.png', height: 60.0,),
        backgroundColor: lightColorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: lightColorScheme.primary,
        activeColor: lightColorScheme.primary,
        inactiveColor: Colors.black.withOpacity(.5),
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index){
          setState(() {
            _bottomNavIndex = index;
            final List<Gift> addedToCartGifts = Gift.addedToCartGift();

            myCart = addedToCartGifts.toSet().toList();
          });
        },
      ),
    );
  }
}
