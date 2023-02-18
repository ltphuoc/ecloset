import 'package:ecloset/Pages/profile_settings_page.dart';
import 'package:ecloset/Widgets/app_bar.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          "https://scontent.fsgn2-7.fna.fbcdn.net/v/t39.30808-6/329249548_621461426653659_6122221015205156424_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=OJO5JzLKrW4AX-rNiby&_nc_ht=scontent.fsgn2-7.fna&oh=00_AfBtd6o9zDXLzvGOq3ZaaE0CDd63xmSn9PpQeXDxJyoA2g&oe=63F69015",
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
                              Text("9",
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
                              Text("87",
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
                          Text("eCloset",
                              style: AppStyles.h4.copyWith(
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
                const Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 2),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text("Tủ quần áo của tôi <3"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "facebook.com/eCloset",
                    style: AppStyles.h4.copyWith(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Divider(
                    height: 10,
                    thickness: 1.3,
                    indent: 10,
                    color: AppColors.brown,
                  ),
                ),
                DefaultTabController(
                    length: 2, // length of tabs
                    initialIndex: 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black,
                            indicatorColor: AppColors.brown,
                            tabs: [
                              Tab(icon: Icon(Icons.grid_on)),
                              Tab(icon: Icon(Icons.person_pin_outlined)),
                            ],
                          ),
                          SizedBox(
                              height: 400,
                              child: TabBarView(children: <Widget>[
                                GridView.count(
                                  crossAxisCount: 3,
                                  shrinkWrap: false,
                                  children: listUrl
                                      .map((e) => InkWell(
                                            child: Image.network(e,
                                                fit: BoxFit.cover),
                                            onTap: () {},
                                          ))
                                      .toList(),
                                ),
                                Center(
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    shrinkWrap: false,
                                    children: listUrl
                                        .sublist(0, 4)
                                        .map((e) => InkWell(
                                              child: Image.network(e,
                                                  fit: BoxFit.cover),
                                              onTap: () {},
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ]))
                        ])),
              ],
            ),
          ),
        ));
  }
}
