import 'package:ecloset/Pages/closet_page.dart';
import 'package:ecloset/Pages/home_page.dart';
import 'package:ecloset/Pages/settings/setting_page.dart';
import 'package:ecloset/Pages/sign_up.dart';
import 'package:ecloset/Pages/user_profile_page.dart';
import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/ViewModel/login_viewModel.dart';
import 'package:ecloset/ViewModel/root_viewModel.dart';
import 'package:ecloset/firebase_options.dart';
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
  Get.put(SignUpPage());
  Get.put(HomePage());
  Get.put(ClosetPage());
  Get.put(const SettingPage());
  Get.put(const UserProfilePage());
}
