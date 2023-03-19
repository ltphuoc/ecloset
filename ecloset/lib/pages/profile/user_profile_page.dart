import 'package:ecloset/ViewModel/account_viewModel.dart';
import 'package:ecloset/Widgets/app_bar.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/pages/community/user_feed.dart';
import 'package:ecloset/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../Utils/request.dart';
import '../community/newsfeed.dart';

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

  List<PostData>? _post;

  Future<void> fetchPost() async {
    try {
      final res = await request
          .get("api/Post", queryParameters: {"Page": 1, "PageSize": 100});

      final List<AccountResponse> accountResponses = List<AccountResponse>.from(
          res.data['data'].map<AccountResponse>(
              (post) => AccountResponse.fromJson(post['accountResponse'])));

      _post = res.data['data']
          .map<PostData>((post) => PostData.fromJson(post))
          .toList();

      var accountId = await getAccountId().then((value) => int.parse(value!));

      var filteredPosts = _post
          ?.where((post) => post.accountResponse?.accountId == accountId)
          .toList();

      _post = filteredPosts;

      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching posts: $e");
      }
    }
  }

  @override
  initState() {
    super.initState();
    fetchPost();
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
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
                          padding: const EdgeInsets.only(left: 16.0, top: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${account?.contactLname}",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles.h4.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.black)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 4, bottom: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Tủ quần áo của tôi <3"),
                              Text(
                                "facebook.com/eCloset",
                                style: AppStyles.h4.copyWith(
                                    color: AppColors.primaryColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
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
                                      Tab(
                                          icon:
                                              Icon(Icons.person_pin_outlined)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 400,
                                    child: TabBarView(children: <Widget>[
                                      _post == null
                                          ? const SizedBox.shrink()
                                          : GridView.count(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              crossAxisCount: 3,
                                              shrinkWrap: false,
                                              children: List.generate(
                                                  _post!.length, (index) {
                                                final e = _post![index];
                                                return InkWell(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: e.postImg == null ||
                                                            e.postImg ==
                                                                "string"
                                                        ? Container(
                                                            color: AppColors
                                                                .greyBg,
                                                          )
                                                        : Image.network(
                                                            e.postImg!,
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                        builder: (context) =>
                                                            UserFeedPage(
                                                          index: index,
                                                        ),
                                                      ),
                                                    ).then(
                                                        (value) => fetchPost());
                                                  },
                                                );
                                              }),
                                            ),
                                      const SizedBox()
                                    ]),
                                  )
                                ])),
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
