import 'package:ecloset/Pages/home_page.dart';
import 'package:ecloset/Pages/settings/setting_page.dart';
import 'package:ecloset/ViewModel/account_viewModel.dart';

import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/ViewModel/login_viewModel.dart';
import 'package:ecloset/ViewModel/root_viewModel.dart';
import 'package:ecloset/firebase_options.dart';
import 'package:ecloset/pages/add_edit_item_page.dart';
import 'package:ecloset/pages/auth/sign_up.dart';
import 'package:ecloset/pages/closet/closet_page.dart';
import 'package:ecloset/pages/outfit/create_outfit_page.dart';
import 'package:ecloset/pages/outfit/save_outfit_page.dart';
import 'package:ecloset/pages/profile/user_profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future setup() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void createRouteBindings() async {
  Get.put(RootViewModel());
  Get.put(LoginViewModel());
  Get.put(ClosetViewModel());
  Get.put(AccountViewModel());
  Get.put(SignUpPage());
  Get.put(const HomePage());
  Get.put(const ClosetPage());
  Get.put(const SettingPage());
  // Get.put(const UserProfilePage());
  // Get.put(const CreateOutfitPage());
}
