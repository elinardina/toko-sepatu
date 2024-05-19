import 'package:flutter/material.dart';
import 'package:tokosepatu/komponen/bottom_nav_bar.dart';
import 'package:tokosepatu/pages/cartpage.dart';
import 'package:tokosepatu/pages/intropage.dart';
import 'package:tokosepatu/pages/shoppage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  void navigatorBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ShopPage(),

    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: ButtomNavBar(onTabChange: (index) => navigatorBottomBar(index),),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
          icon: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Icon(Icons.menu, color: Colors.black,),
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
          )
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(child: Image.asset('assets/image/logo.jpg')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(
                color: Colors.grey[800],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: Text(
                  'Home', style: TextStyle(color: Colors.black),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                title: Text(
                  'About', style: TextStyle(color: Colors.black),
                ),
              ),
            ),
              ],
            ),

            GestureDetector(
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IntroPage(),
                    )),
              child: Padding(
                padding: EdgeInsets.only(left: 25.0, bottom: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Logout', style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      
      body: _pages[_selectedIndex],
    );
  }
}