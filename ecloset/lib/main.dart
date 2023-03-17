import 'dart:io';

import 'package:ecloset/pages/app.dart';
import 'package:ecloset/pages/auth/login.dart';
import 'package:ecloset/pages/auth/sign_up.dart';
import 'package:ecloset/pages/closet/closet_page.dart';
import 'package:ecloset/pages/community/newsfeed.dart';
import 'package:ecloset/pages/outfit/create_outfit_page.dart';
import 'package:ecloset/pages/outfit/outfit_detail_page.dart';
import 'package:ecloset/pages/outfit/outfit_page.dart';
import 'package:ecloset/pages/outfit/save_outfit_page.dart';
import 'package:ecloset/pages/profile/profile_settings_page.dart';
import 'package:ecloset/pages/profile/user_profile_page.dart';
import 'package:ecloset/pages/settings/update_premium.dart';
import 'package:ecloset/setup.dart';
import 'package:ecloset/utils/pageNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'Pages/add_edit_item_page.dart';
import 'Pages/home_page.dart';
import 'Pages/settings/setting_page.dart';
import 'Pages/start_up.dart';
import 'Utils/request.dart';
import 'Utils/routes_name.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await setup();
  createRouteBindings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      title: 'eCloset',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RouteName.login:
            return ScaleRoute(page: Login());
          case RouteName.signUp:
            return ScaleRoute(page: SignUpPage());
          case RouteName.app:
            return CupertinoPageRoute(
                builder: (context) => const App(), settings: settings);
          case RouteName.settingPage:
            return CupertinoPageRoute(
                builder: (context) => const SettingPage(), settings: settings);

          case RouteName.homePage:
            return CupertinoPageRoute(
                builder: (context) => const HomePage(), settings: settings);
          case RouteName.newsFeed:
            return CupertinoPageRoute(
                builder: (context) => const NewsFeedPage(), settings: settings);

          case RouteName.closetPage:
            return CupertinoPageRoute(
                builder: (context) => const ClosetPage(), settings: settings);
          case RouteName.addEditItemPage:
            return CupertinoPageRoute(
                builder: (context) => AddEditItemPage(
                      id: settings.arguments as int,
                    ));

          case RouteName.outfitPage:
            return CupertinoPageRoute(
                builder: (context) => const OutfitPage(), settings: settings);
          case RouteName.outfitDetail:
            return CupertinoPageRoute(
                builder: (context) => const OutfitDetailPage(),
                settings: settings);
          case RouteName.createOutfitPage:
            return CupertinoPageRoute(
                builder: (context) => const CreateOutfitPage(),
                settings: settings);
          case RouteName.saveOutfitPage:
            return CupertinoPageRoute(
                builder: (context) => SaveOutfitPage(
                      imageByte: settings.arguments,
                    ));

          case RouteName.profileSettingPage:
            return CupertinoPageRoute(
                builder: (context) => const ProfileSettingsPage(),
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
      home: const StartUpView(),
      // home: App(),
    );
  }
}
