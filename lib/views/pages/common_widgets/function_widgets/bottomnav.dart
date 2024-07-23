import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/pages/first_page/bottom_nav_first_page.dart';

CurvedNavigationBar bottomNav(BuildContext context) {
  return CurvedNavigationBar(
    index: 0,
    height: 60.0,
    items: <Widget>[
      Icon(Icons.home, size: 30, color: primary),
      Icon(Icons.search, size: 30, color: primary),
      Icon(Icons.add, size: 30, color: primary),
      Icon(Icons.chat, size: 30, color: primary),
      Icon(Icons.person, size: 30, color: primary),
    ],
    color: Theme.of(context).brightness == Brightness.light ? whiteColor : black,
    buttonBackgroundColor: Theme.of(context).brightness == Brightness.light ? whiteColor : black,
    backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
    animationCurve: Curves.easeInOut,
    animationDuration: Duration(milliseconds: 600),
    onTap: (index) {
      currentPage.value = index;
    },
  );
}
