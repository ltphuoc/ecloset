import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/Pages/home_page.dart';
import 'package:flutter/material.dart';

import '../pages/profile/user_profile_page.dart';

enum AddMenuAction { addItem, add2, add3 }

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.primaryColor,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              // padding: const EdgeInsets.only(left: 28.0),
              icon: const Icon(
                Icons.home,
                color: AppColors.secondaryColor,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false);
              },
            ),
            IconButton(
              // padding: const EdgeInsets.only(right: 28.0),
              icon: const Icon(
                Icons.abc,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              // padding: const EdgeInsets.only(left: 28.0),
              icon: const Icon(
                Icons.abc,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              // padding: const EdgeInsets.only(right: 28.0),
              icon: const Icon(
                Icons.people,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfilePage()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
