import 'package:ecloset/Pages/home_page.dart';
import 'package:ecloset/Pages/user_profile_page.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/pages/closet_page.dart';
import 'package:ecloset/pages/newsfeed.dart';
import 'package:ecloset/pages/sell_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../Utils/routes_name.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    const SellItemPage(),
    const NewsFeedPage(),
    const UserProfilePage(),
  ];
  var speedDialDirection = SpeedDialDirection.up;
  var isDialOpen = ValueNotifier<bool>(false);
  var closeManually = false;
  var renderOverlay = true;
  var useRAnimation = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SpeedDial(
          backgroundColor: AppColors.brown,
          overlayOpacity: 0,
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 20,
          mini: false,
          openCloseDial: isDialOpen,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          buttonSize: const Size(56, 56),
          childrenButtonSize: const Size(56, 56),
          visible: true,
          direction: speedDialDirection,
          closeManually: closeManually,
          renderOverlay: renderOverlay,
          useRotationAnimation: useRAnimation,
          elevation: 8.0,
          animationCurve: Curves.elasticInOut,
          isOpenOnStart: false,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.post_add),
              backgroundColor: AppColors.lightBrown,
              foregroundColor: Colors.black54,
              labelBackgroundColor: Colors.amber[50],
              labelStyle: const TextStyle(color: Colors.black54),
              label: 'Add new post',
              onTap: () {},
            ),
            SpeedDialChild(
              child: const Icon(Icons.document_scanner_outlined),
              backgroundColor: AppColors.lightBrown,
              foregroundColor: Colors.black54,
              labelBackgroundColor: Colors.amber[50],
              labelStyle: const TextStyle(color: Colors.black54),
              label: 'Add new outfit',
              onTap: () =>
                  {Navigator.pushNamed(context, RouteName.createOutfitPage)},
            ),
            SpeedDialChild(
              child: const Icon(Icons.checkroom),
              backgroundColor: AppColors.lightBrown,
              foregroundColor: Colors.black54,
              labelBackgroundColor: Colors.amber[50],
              labelStyle: const TextStyle(color: Colors.black54),
              label: 'Add new clothes',
              visible: true,
              onTap: () =>
                  {Navigator.pushNamed(context, RouteName.addEditItemPage)},
            ),
          ],
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(), //shape of notch
          notchMargin: 3,
          color: AppColors.primaryColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: IconButton(
                  icon: Icon(
                    Icons.home,
                    color: _selectedIndex == 0
                        ? AppColors.brown
                        : AppColors.greyBg,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 56),
                child: IconButton(
                  icon: Icon(
                    Icons.checkroom,
                    color: _selectedIndex == 1
                        ? AppColors.brown
                        : AppColors.greyBg,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.group,
                  color:
                      _selectedIndex == 2 ? AppColors.brown : AppColors.greyBg,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: Icon(
                    Icons.person,
                    color: _selectedIndex == 3
                        ? AppColors.brown
                        : AppColors.greyBg,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
