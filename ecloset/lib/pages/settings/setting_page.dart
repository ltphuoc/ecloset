import 'package:ecloset/pages/user_profile_page.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      backgroundColor: const Color(0xfff6f6f6),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "Account",
                children: [
                  ListTile(
                    title: Text('Account'),
                    leading: Icon(CupertinoIcons.profile_circled),
                    trailing: const Icon(CupertinoIcons.forward, size: 18),
                    onTap: () {
                      Get.toNamed(RouteName.userProfilePage);
                    },
                  ),
                  // _CustomListTile(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, RouteName.userProfilePage);
                  //     },
                  //     title: "Account",
                  //     icon: CupertinoIcons.profile_circled),
                  _CustomListTile(
                      onPressed: () {
                        Get.toNamed(RouteName.userProfilePage);
                      },
                      title: "Upgrade Premium",
                      icon: CupertinoIcons.cloud_download),
                  _CustomListTile(
                      onPressed: () {
                        Get.toNamed(RouteName.userProfilePage);
                      },
                      title: "Security",
                      icon: CupertinoIcons.lock_shield),
                  _CustomListTile(
                      onPressed: () {
                        Get.toNamed(RouteName.userProfilePage);
                      },
                      title: "Dark Mode",
                      icon: CupertinoIcons.moon,
                      trailing:
                          CupertinoSwitch(value: false, onChanged: (value) {})),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile(
      {Key? key,
      required this.title,
      required this.icon,
      this.trailing,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: () {
        onPressed;
      },
    );
  }
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
