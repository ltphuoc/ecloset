import 'dart:typed_data';

import 'package:ecloset/pages/closet/add_edit_item_page.dart';
import 'package:ecloset/pages/app.dart';
import 'package:ecloset/pages/closet/closet_page.dart';
import 'package:ecloset/pages/outfit/create_outfit_page.dart';
import 'package:ecloset/pages/home/home_page.dart';
import 'package:ecloset/pages/outfit/outfit_page.dart';
import 'package:ecloset/pages/profile/profile_settings_page.dart';
import 'package:ecloset/pages/profile/user_profile_page.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:flutter/material.dart';

import '../pages/outfit/save_outfit_page.dart';
import '../pages/splash_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashPage:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RouteName.app:
        return MaterialPageRoute(builder: (context) => const App());

      case RouteName.homePage:
        return MaterialPageRoute(builder: (context) => HomePage());

      case RouteName.closetPage:
        return MaterialPageRoute(builder: (context) => ClosetPage());
      case RouteName.addEditItemPage:
        return MaterialPageRoute(
            builder: (context) => AddEditItemPage(
                  closet: settings.arguments as Closet?,
                ));

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
