import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/Pages/home_page.dart';
import 'package:ecloset/Pages/user_profile_page.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/pages/closet_page.dart';
import 'package:ecloset/pages/newsfeed.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:ecloset/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
  var speedDialDirection = SpeedDialDirection.up;
  var isDialOpen = ValueNotifier<bool>(false);
  var closeManually = false;
  var renderOverlay = true;
  var useRAnimation = true;
  var rmicons = false;

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
              child: !rmicons ? const Icon(Icons.post_add) : null,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Add new post',
              onTap: () => setState(() => rmicons = !rmicons),
            ),
            SpeedDialChild(
              child: !rmicons ? const Icon(Icons.abc) : null,
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              labelBackgroundColor: AppColors.whiteBg,
              label: 'Add new outfit',
              onTap: () => debugPrint('SECOND CHILD'),
            ),
            SpeedDialChild(
              child: !rmicons ? const Icon(Icons.abc) : null,
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              label: 'Add new clothes',
              visible: true,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(("Third Child Pressed")))),
              onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
            ),
          ],
        ),

        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   tooltip: 'Increment',
        //   elevation: 2.0,
        //   backgroundColor: AppColors.primaryColor,
        //   child: PopupMenuButton<AddMenuAction>(
        //     offset: const Offset(100, -180),
        //     color: AppColors.whiteBg,
        //     tooltip: "",
        //     icon: const Icon(Icons.add),
        //     onSelected: (value) {
        //       if (value == AddMenuAction.addEditItem) {
        //         Navigator.pushNamed(context, RouteName.addEditItemPage);
        //       } else if (value == AddMenuAction.addOutfit) {
        //         Navigator.pushNamed(context, RouteName.createOutfitPage);
        //       }
        //     },
        //     shape: const RoundedRectangleBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(15.0))),
        //     itemBuilder: (context) {
        //       return <PopupMenuEntry<AddMenuAction>>[
        //         PopupMenuItem<AddMenuAction>(
        //           value: AddMenuAction.addEditItem,
        //           child: Text('Add new item',
        //               style: AppStyles.h4.copyWith(
        //                 color: AppColors.black,
        //               )),
        //         ),
        //         PopupMenuItem<AddMenuAction>(
        //           value: AddMenuAction.addOutfit,
        //           child: Text(
        //             'Add new outfit',
        //             style: AppStyles.h4.copyWith(
        //               color: AppColors.black,
        //             ),
        //           ),
        //         ),
        //         PopupMenuItem<AddMenuAction>(
        //           value: AddMenuAction.add3,
        //           child: Text(
        //             'Add new collection',
        //             style: AppStyles.h4.copyWith(
        //               color: AppColors.black,
        //             ),
        //           ),
        //         ),
        //       ];
        //     },
        //   ),
        // ),
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
              Container(
                // margin: const EdgeInsets.only(left: 56),

                child: IconButton(
                  icon: Icon(
                    Icons.group,
                    color: _selectedIndex == 2
                        ? AppColors.brown
                        : AppColors.greyBg,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                ),
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
      ),
    );
  }
}
