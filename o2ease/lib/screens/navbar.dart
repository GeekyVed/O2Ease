import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:o2ease/constants/colors.dart';
import 'package:o2ease/screens/auth_part/getstarted.dart';
import 'package:o2ease/screens/auth_part/login.dart';
import 'package:o2ease/screens/auth_part/signup.dart';
import 'package:o2ease/screens/home_page.dart';
import 'package:page_transition/page_transition.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  int _bottomNavIndex = 0;

  // List of the pages
  List<Widget> _widgetOptions() {
    return [
      const HomePage(),
      LoginScreen(),
      ];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.add
  ];

  //List of the pages titles
  List<String> titleList = [
    'Home',
    'Precautions'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleList[_bottomNavIndex],
              style: TextStyle(
                color: AppColors.background,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Icon(
              Icons.notifications,
              color: AppColors.background,
              size: 30.0,
            )
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: AppColors.primaryColor1,
          activeColor: AppColors.primaryColor2,
          inactiveColor: Colors.black.withOpacity(.5),
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
          }),
    );
  }
}