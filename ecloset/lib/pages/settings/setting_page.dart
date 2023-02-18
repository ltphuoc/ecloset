import 'package:ecloset/ViewModel/login_viewModel.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/pages/user_profile_page.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:ecloset/widgets/button_global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          // constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "",
                children: [
                  ButtonNavigateSettingPage(
                    bgColor: AppColors.primaryColor,
                    iconData: CupertinoIcons.profile_circled,
                    text1: 'Account',
                    text2: 'Personal Information',
                    onPressed: () {
                      // Navigator.pushNamed(context, RouteName.userProfilePage);
                      Get.toNamed(RouteName.app);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ButtonNavigateSettingPage(
                    bgColor: AppColors.primaryColor,
                    iconData: CupertinoIcons.creditcard,
                    text1: 'Update Premium',
                    text2: 'Connected Credit Cards',
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ButtonNavigateSettingPage(
                    bgColor: AppColors.primaryColor,
                    iconData: CupertinoIcons.creditcard,
                    text1: 'Security',
                    text2: 'Change password',
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ButtonNavigateSettingPage(
                    bgColor: Colors.red,
                    iconData: Icons.logout,
                    text1: 'Log Out',
                    text2: 'Are you sure?',
                    onPressed: () {
                      _signOut();
                    },
                  ),
                  // _CustomListTile(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, RouteName.userProfilePage);
                  //     },
                  //     title: "Account",
                  //     icon: CupertinoIcons.profile_circled),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
  Get.offAllNamed(RouteName.login);
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
