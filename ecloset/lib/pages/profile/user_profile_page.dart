import 'package:ecloset/ViewModel/account_viewModel.dart';
import 'package:ecloset/Widgets/app_bar.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/pages/profile/profile_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  List<String> listUrl = [
    "https://i.pinimg.com/564x/c9/57/90/c95790848baf26ca62c773caab2f761c.jpg",
    "https://i.pinimg.com/236x/42/35/81/423581e1f19b991c1378d5ee24acacf1.jpg",
    "https://i.pinimg.com/236x/d6/e7/6b/d6e76bb292d51f686adaac9c78112f0e.jpg",
    "https://i.pinimg.com/236x/dc/e1/be/dce1be915b9d70fe44d9ee67be41b4ba.jpg",
    "https://i.pinimg.com/236x/3d/9a/79/3d9a79f0958f109006913076ee15abbb.jpg",
    "https://i.pinimg.com/236x/5b/cf/b3/5bcfb3ccd93fedea4abba0da22ed75f3.jpg",
    "https://i.pinimg.com/236x/6a/6d/f8/6a6df8d1bc62954b1a266877a197c5b9.jpg",
    "https://i.pinimg.com/236x/0b/c2/23/0bc2236ab9c290b3ed80038b454c438d.jpg",
    "https://i.pinimg.com/236x/16/38/9f/16389f4527b75a58f8d62d75bedc7cb8.jpg",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: AccountViewModel(),
        child: ScopedModelDescendant<AccountViewModel>(
          builder: (context, child, model) {
            var account = Get.find<AccountViewModel>().account;

            return Scaffold(
                appBar: const MainAppBar(),
                backgroundColor: AppColors.whiteBg,
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
                                backgroundImage: account != null
                                    ? NetworkImage(account.avatar.toString())
                                    : const NetworkImage(
                                        "https://picsum.photos/200"),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                      Text(account?.follower ?? "0",
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
                                      Text(account?.following ?? "0",
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text("${account?.contactLname}",
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.h4.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.black)),
                              ),
                              Flexible(
                                flex: 2,
                                child: Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.brown,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProfileSettingsPage()));
                                      },
                                      child: Text("Manage your profile",
                                          style: AppStyles.h5.copyWith(
                                              fontWeight: FontWeight.normal,
                                              color: AppColors.black))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tủ quần áo của tôi <3"),
                              Text(
                                "facebook.com/eCloset",
                                style: AppStyles.h4.copyWith(
                                    color: AppColors.primaryColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 8.0),
                        //   child: Divider(
                        //     height: 10,
                        //     thickness: 1.3,
                        //     indent: 10,
                        //     color: AppColors.brown,
                        //   ),
                        // ),
                        DefaultTabController(
                            length: 2, // length of tabs
                            initialIndex: 0,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  TabBar(
                                    labelColor: Colors.black,
                                    unselectedLabelColor: Colors.black,
                                    indicatorColor: AppColors.brown,
                                    tabs: [
                                      Tab(icon: Icon(Icons.grid_on)),
                                      Tab(
                                          icon:
                                              Icon(Icons.person_pin_outlined)),
                                    ],
                                  ),
                                  SizedBox(
                                      height: 400,
                                      child: TabBarView(children: <Widget>[
                                        SizedBox(),
                                        SizedBox()
                                        // GridView.count(
                                        //   physics:
                                        //       const NeverScrollableScrollPhysics(),
                                        //   crossAxisCount: 3,
                                        //   shrinkWrap: false,
                                        //   children: listUrl
                                        //       .map((e) => InkWell(
                                        //             child: Image.network(e,
                                        //                 fit: BoxFit.cover),
                                        //             onTap: () {},
                                        //           ))
                                        //       .toList(),
                                        // ),
                                        // Center(
                                        //   child: GridView.count(
                                        //     physics:
                                        //         const NeverScrollableScrollPhysics(),
                                        //     crossAxisCount: 3,
                                        //     shrinkWrap: false,
                                        //     children: listUrl
                                        //         .sublist(0, 4)
                                        //         .map((e) => InkWell(
                                        //               child: Image.network(e,
                                        //                   fit: BoxFit.cover),
                                        //               onTap: () {},
                                        //             ))
                                        //         .toList(),
                                        //   ),
                                        // ),
                                      ]))
                                ])),
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
