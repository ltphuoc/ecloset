import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/Pages/home_page.dart';
import 'package:ecloset/Pages/user_profile_page.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    Container(),
    Container(),
    const UserProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            tooltip: "",
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            tooltip: "",
            icon: Icon(Icons.abc),
            label: "Abc",
          ),
          BottomNavigationBarItem(
            tooltip: "",
            icon: Icon(Icons.abc),
            label: "Abc",
          ),
          BottomNavigationBarItem(
            tooltip: "",
            icon: Icon(Icons.people),
            label: "Profile",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primaryColor,
        selectedItemColor: AppColors.secondaryColor,
        unselectedItemColor: AppColors.textWhite,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
