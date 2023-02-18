import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/ViewModel/root_viewModel.dart';
import 'package:ecloset/firebase_options.dart';
import 'package:ecloset/pages/settings/setting_page.dart';
import 'package:ecloset/pages/user_profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future setup() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void createRouteBindings() async {
  Get.put(RootViewModel());
  Get.put(ClosetViewModel());
  Get.put(const SettingPage());
  Get.put(const UserProfilePage());
}
