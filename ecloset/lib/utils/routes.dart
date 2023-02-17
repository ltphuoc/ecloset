import 'dart:typed_data';

import 'package:ecloset/Pages/add_edit_item_page.dart';
import 'package:ecloset/Pages/app.dart';
import 'package:ecloset/Pages/closet_page.dart';
import 'package:ecloset/Pages/create_outfit_page.dart';
import 'package:ecloset/Pages/home_page.dart';
import 'package:ecloset/Pages/outfit_page.dart';
import 'package:ecloset/Pages/profile_settings_page.dart';
import 'package:ecloset/Pages/user_profile_page.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:flutter/material.dart';

import '../Pages/save_outfit_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.app:
        return MaterialPageRoute(builder: (context) => App());

      case RouteName.homePage:
        return MaterialPageRoute(builder: (context) => HomePage());

      case RouteName.closetPage:
        return MaterialPageRoute(builder: (context) => ClosetPage());
      case RouteName.addEditItemPage:
      // return MaterialPageRoute(
      //     builder: (context) => AddEditItemPage(
      //           closet: settings.arguments as Closet?,
      //         ));

      case RouteName.outfitPage:
        return MaterialPageRoute(builder: (context) => OutfitPage());
      case RouteName.createOutfitPage:
        return MaterialPageRoute(builder: (context) => CreateOutfitPage());
      case RouteName.saveOutfitPage:
        return MaterialPageRoute(
            builder: (context) => SaveOutfitPage(
                  imageByte: settings.arguments,
                ));

      case RouteName.profileSettingPage:
        return MaterialPageRoute(builder: (context) => ProfileSettingsPage());
      case RouteName.userProfilePage:
        return MaterialPageRoute(builder: (context) => UserProfilePage());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(child: Text("No route defined")),
          );
        });
    }
  }
}
