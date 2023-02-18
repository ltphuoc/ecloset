import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/Pages/home_page.dart';
import 'package:ecloset/Pages/user_profile_page.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.abc,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.abc,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.people,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       tooltip: "",
      //       icon: Icon(Icons.home),
      //       label: "Home",
      //     ),
      //     BottomNavigationBarItem(
      //       tooltip: "",
      //       icon: Icon(Icons.abc),
      //       label: "Abc",
      //     ),
      //     BottomNavigationBarItem(
      //       tooltip: "",
      //       icon: Icon(Icons.abc),
      //       label: "Abc",
      //     ),
      //     BottomNavigationBarItem(
      //       tooltip: "",
      //       icon: Icon(Icons.people),
      //       label: "Profile",
      //     ),
      //   ],
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: AppColors.primaryColor,
      //   selectedItemColor: AppColors.secondaryColor,
      //   unselectedItemColor: AppColors.textWhite,
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
