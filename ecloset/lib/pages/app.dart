import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/Pages/home_page.dart';
import 'package:ecloset/Pages/user_profile_page.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/pages/closet_page.dart';
import 'package:ecloset/pages/newsfeed.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:ecloset/widgets/app_bar.dart';
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
    const ClosetPage(),
    const NewsFeedPage(),
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
        elevation: 2.0,
        backgroundColor: AppColors.primaryColor,
        child: PopupMenuButton<AddMenuAction>(
          offset: const Offset(100, 0),
          color: AppColors.whiteBg,
          tooltip: "",
          icon: const Icon(Icons.add),
          onSelected: (value) {
            if (value == AddMenuAction.addEditItem) {
              Navigator.pushNamed(context, RouteName.addEditItemPage);
            } else if (value == AddMenuAction.addOutfit) {
              Navigator.pushNamed(context, RouteName.createOutfitPage);
            }
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          itemBuilder: (context) {
            return <PopupMenuEntry<AddMenuAction>>[
              PopupMenuItem<AddMenuAction>(
                value: AddMenuAction.addEditItem,
                child: Text('Add new item',
                    style: AppStyles.h4.copyWith(
                      color: AppColors.black,
                    )),
              ),
              PopupMenuItem<AddMenuAction>(
                value: AddMenuAction.addOutfit,
                child: Text(
                  'Add new outfit',
                  style: AppStyles.h4.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
              PopupMenuItem<AddMenuAction>(
                value: AddMenuAction.add3,
                child: Text(
                  'Add new collection',
                  style: AppStyles.h4.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
            ];
          },
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 3,
        color: AppColors.primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? AppColors.brown : AppColors.greyBg,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.checkroom,
                color: _selectedIndex == 1 ? AppColors.brown : AppColors.greyBg,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.group,
                color: _selectedIndex == 2 ? AppColors.brown : AppColors.greyBg,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: _selectedIndex == 3 ? AppColors.brown : AppColors.greyBg,
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
