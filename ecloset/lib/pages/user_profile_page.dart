import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/Pages/profile_settings_page.dart';
import 'package:ecloset/Widgets/app_bar.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  List<String> listUrl = [
    "https://picsum.photos/200",
    "https://picsum.photos/300",
    "https://picsum.photos/400",
    "https://picsum.photos/500",
    "https://picsum.photos/600",
    "https://picsum.photos/800",
    "https://picsum.photos/900",
    "https://picsum.photos/700",
    "https://picsum.photos/701",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MainAppBar(),
        backgroundColor: AppColors.whiteBg,
        // bottomNavigationBar: BottomBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          "https://picsum.photos/id/237/200/300",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text("0",
                                  style: AppStyles.h5.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.black)),
                              Text(
                                "Posts",
                                style: AppStyles.h5.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.black),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text("0",
                                  style: AppStyles.h5.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.black)),
                              Text(
                                "Followers",
                                style: AppStyles.h5.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.black),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text("0",
                                  style: AppStyles.h5.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.black)),
                              Text(
                                "Following",
                                style: AppStyles.h5.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text("User Name",
                              style: AppStyles.h5.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.black)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.brown,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileSettingsPage()));
                              },
                              child: Text("Manage your profile",
                                  style: AppStyles.h5.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.black))),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Divider(
                    height: 10,
                    thickness: 1.3,
                    indent: 10,
                    color: AppColors.brown,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Center(
                    child: Text("Tủ quần áo của tôi <3"),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                GridView.count(
                  crossAxisCount: 3,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: listUrl
                      .map((e) => InkWell(
                            child: Image.network(e, fit: BoxFit.cover),
                            onTap: () {},
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        ));
  }
}
