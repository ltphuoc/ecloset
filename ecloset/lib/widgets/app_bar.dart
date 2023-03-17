import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Pages/app.dart';

enum AddMenuAction { addEditItem, addOutfit, add3 }

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: InkWell(
        onTap: () {
          Get.offAll(() => const App());
        },
        child: Text(
          "eCloset",
          style: AppStyles.h2,
        ),
      ),
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.settingPage);
            },
            icon: const Icon(Icons.settings))
      ],
    );
  }
}
