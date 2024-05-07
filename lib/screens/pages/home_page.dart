// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_diet_app/screens/pages/favorite_page.dart';
import 'package:food_diet_app/screens/pages/home_screen.dart';
import 'package:food_diet_app/screens/pages/profile_screen.dart';
import 'package:food_diet_app/screens/pages/search_page.dart';

import 'package:food_diet_app/utils/color_constants.dart';

import 'main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> pages;

  @override
  void initState() {
    pages = <Widget>[
      HomeScreen(),
      SearchPage(),
      FavoritePage(),
      ProfileScreen()
    ];
    super.initState();
  }

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1601662528567-526cd06f6582?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=415&q=80')),
        ),
        child: pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: KprimaryColor,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.apps), tooltip: 'Home', label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                tooltip: 'Favorite',
                label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                ),
                tooltip: 'Profile',
                label: 'Profile')
          ]),
    );
  }
}
