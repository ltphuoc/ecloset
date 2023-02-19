import 'dart:io';

import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/Pages/sign_up.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/firebase_options.dart';
import 'package:ecloset/Pages/add_edit_item_page.dart';
import 'package:ecloset/Pages/app.dart';
import 'package:ecloset/Pages/closet_page.dart';
import 'package:ecloset/Pages/create_outfit_page.dart';
import 'package:ecloset/Pages/home_page.dart';
import 'package:ecloset/Pages/login.dart';
import 'package:ecloset/Pages/outfit_page.dart';
import 'package:ecloset/Pages/profile_settings_page.dart';
import 'package:ecloset/Pages/save_outfit_page.dart';
import 'package:ecloset/Pages/start_up.dart';
import 'package:ecloset/Pages/user_profile_page.dart';
import 'package:ecloset/pages/newsfeed.dart';
import 'package:ecloset/pages/settings/setting_page.dart';
import 'package:ecloset/pages/update_premium.dart';
import 'package:ecloset/setup.dart';
import 'package:ecloset/utils/pageNavigation.dart';
import 'package:ecloset/utils/request.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await setup();
  createRouteBindings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'eCloset',
    //   theme: ThemeData(
    //     primaryColor: AppColors.primaryColor,
    //   ),
    //   initialRoute: RouteName.app,
    //   onGenerateRoute: Routes.generateRoute,
    // );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecloset',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RouteName.login:
            return ScaleRoute(page: Login());
          case RouteName.signUp:
            return ScaleRoute(page: SignUpPage());
          case RouteName.app:
            return CupertinoPageRoute(
                builder: (context) => App(), settings: settings);
          case RouteName.settingPage:
            return CupertinoPageRoute(
                builder: (context) => SettingPage(), settings: settings);

          case RouteName.homePage:
            return CupertinoPageRoute(
                builder: (context) => HomePage(), settings: settings);
          case RouteName.newsFeed:
            return CupertinoPageRoute(
                builder: (context) => NewsFeedPage(), settings: settings);

          case RouteName.closetPage:
            return CupertinoPageRoute(
                builder: (context) => ClosetPage(), settings: settings);
          case RouteName.addEditItemPage:
            return CupertinoPageRoute(
                builder: (context) => AddEditItemPage(
                      closet: settings.arguments as ClosetData,
                    ));

          case RouteName.outfitPage:
            return CupertinoPageRoute(
                builder: (context) => OutfitPage(), settings: settings);
          case RouteName.createOutfitPage:
            return CupertinoPageRoute(
                builder: (context) => CreateOutfitPage(), settings: settings);
          case RouteName.saveOutfitPage:
            return CupertinoPageRoute(
                builder: (context) => SaveOutfitPage(
                      imageByte: settings.arguments,
                    ));

          case RouteName.profileSettingPage:
            return CupertinoPageRoute(
                builder: (context) => ProfileSettingsPage(),
                settings: settings);
          case RouteName.updatePremium:
            return CupertinoPageRoute(
                builder: (context) => const UpdatePremierum(),
                settings: settings);
          case RouteName.userProfilePage:
            return CupertinoPageRoute(
                builder: (context) => const UserProfilePage(),
                settings: settings);
          // case RouteName.settingPage:
          //   return CupertinoPageRoute(
          //       builder: (context) => const SettingPage(), settings: settings);
          default:
            return MaterialPageRoute(builder: (context) {
              return const Scaffold(
                body: Center(child: Text("No route defined")),
              );
            });
        }
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // primaryColor: AppColors.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartUpView(),
    );
  }
}
