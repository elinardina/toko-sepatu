import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class ButtomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  ButtomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.grey.shade700,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (value) =>onTabChange!(value) ,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Belanja',
            ),

            GButton(
            icon: Icons.shopping_bag_rounded,
            text: 'Keranjang',
            )
        ],
      ),
    );
  }
}