import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:flutter/material.dart';

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
      title: Text(
        "eCloset",
        style: AppStyles.h2,
      ),
      elevation: 0,
      actions: [
        PopupMenuButton<AddMenuAction>(
          color: AppColors.black,
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
                child: Text(
                  'Add new item',
                  style: AppStyles.h4,
                ),
              ),
              PopupMenuItem<AddMenuAction>(
                value: AddMenuAction.addOutfit,
                child: Text(
                  'Add new outfit',
                  style: AppStyles.h4,
                ),
              ),
              PopupMenuItem<AddMenuAction>(
                value: AddMenuAction.add3,
                child: Text(
                  'Add new collection',
                  style: AppStyles.h4,
                ),
              ),
            ];
          },
        ),
        // Builder(
        //       builder: (context) => IconButton(
        //           onPressed: () {
        //             Navigator.pushNamed(context, RouteName.settingPage);
        //           },
        //           icon: const Icon(Icons.settings))),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.settingPage);
            },
            icon: const Icon(Icons.settings))
      ],
    );
  }
}
