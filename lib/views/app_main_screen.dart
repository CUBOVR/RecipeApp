import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: Colors.green,
        elevation: 0,
        iconSize: 28,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.lime,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w600,
        ),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Iconsax.home5), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.heart5),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.calendar5),
            label: "Meal plan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.setting_21),
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
