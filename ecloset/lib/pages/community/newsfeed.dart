import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../Utils/request.dart';

class FeedItem {
  final int postId;
  final String? content;
  final String? imageUrl;
  final User user;
  final int commentsCount;
  final int likesCount;
  final int retweetsCount;

  FeedItem(
      {required this.postId,
      this.content,
      this.imageUrl,
      required this.user,
      this.commentsCount = 0,
      this.likesCount = 0,
      this.retweetsCount = 0});
}

class User {
  final String fullName;
  final String imageUrl;
  final String userName;

  User({
    required this.fullName,
    required this.userName,
    required this.imageUrl,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      imageUrl: json['imageUrl'],
      userName: json['userName'],
    );
  }
}

class PostData {
  int? postId;
  int? productId;
  String? postContent;
  int? accountId;
  String? postImg;
  AccountResponse? accountResponse;

  PostData(
      {this.postId,
      this.productId,
      this.postContent,
      this.accountId,
      this.postImg,
      this.accountResponse});

  PostData.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    productId = json['productId'];
    postContent = json['postContent'];
    accountId = json['accountId'];
    postImg = json['postImg'];
    accountResponse = json['accountResponse'] != null
        ? AccountResponse.fromJson(json['accountResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['productId'] = productId;
    data['postContent'] = postContent;
    data['accountId'] = accountId;
    data['postImg'] = postImg;
    if (accountResponse != null) {
      data['accountResponse'] = accountResponse!.toJson();
    }
    return data;
  }
}

class AccountResponse {
  int? accountId;
  String? contactFname;
  String? contactLname;
  String? email;
  String? phone;
  String? password;
  int? roleId;
  String? country;
  String? city;
  String? district;
  String? province;
  String? address;
  String? avatar;
  String? follower;
  String? following;
  int? brandId;

  AccountResponse(
      {this.accountId,
      this.contactFname,
      this.contactLname,
      this.email,
      this.phone,
      this.password,
      this.roleId,
      this.country,
      this.city,
      this.district,
      this.province,
      this.address,
      this.avatar,
      this.follower,
      this.following,
      this.brandId});

  AccountResponse.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    contactFname = json['contactFname'];
    contactLname = json['contactLname'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    roleId = json['roleId'];
    country = json['country'];
    city = json['city'];
    district = json['district'];
    province = json['province'];
    address = json['address'];
    avatar = json['avatar'];
    follower = json['follower'];
    following = json['following'];
    brandId = json['brandId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['contactFname'] = contactFname;
    data['contactLname'] = contactLname;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['roleId'] = roleId;
    data['country'] = country;
    data['city'] = city;
    data['district'] = district;
    data['province'] = province;
    data['address'] = address;
    data['avatar'] = avatar;
    data['follower'] = follower;
    data['following'] = following;
    data['brandId'] = brandId;
    return data;
  }
}

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({Key? key}) : super(key: key);

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  List<PostData>? _post;
  List<User>? _users;
  List<FeedItem>? _feedItems;
  ItemScrollController _scrollController = ItemScrollController();

  Future<void> fetchPost() async {
    try {
      final res = await request
          .get("api/Post", queryParameters: {"Page": 1, "PageSize": 100});

      final List<AccountResponse> accountResponses = List<AccountResponse>.from(
          res.data['data'].map<AccountResponse>(
              (post) => AccountResponse.fromJson(post['accountResponse'])));

      _users = accountResponses
          .map<User>((accountResponse) => User(
                fullName:
                    "${accountResponse.contactFname} ${accountResponse.contactLname}",
                userName: accountResponse.email ?? "",
                imageUrl: accountResponse.avatar ?? "",
              ))
          .toList();
      _feedItems = res.data['data']
          .map<FeedItem>((postData) {
            final user = _users?.firstWhere(
              (user) =>
                  "${user.fullName} ${user.userName}" ==
                  "${postData['accountResponse']['contactFname']} ${postData['accountResponse']['contactLname']} ${postData['accountResponse']['email']}",
            );

            return FeedItem(
              postId: postData['postId'],
              content: postData['postContent'],
              user: User(
                fullName: user!.fullName.replaceAll("null", "").trim(),
                userName: user.userName,
                imageUrl: user.imageUrl,
              ),
              imageUrl: postData['postImg'],
              likesCount: 0,
              commentsCount: 0,
              retweetsCount: 0,
            );
          })
          .where((feedItem) => feedItem.user != null)
          .toList();

      // _post = res.data['data']
      //     .map<PostData>((post) => PostData.fromJson(post))
      //     .toList();

      setState(() {});
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }

  @override
  initState() {
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      backgroundColor: AppColors.whiteBg,
      body: _feedItems == null
          ? const Center(child: CircularProgressIndicator())
          : ScrollablePositionedList.builder(
              itemScrollController: _scrollController,
              itemCount: _feedItems!.length,
              itemBuilder: (context, int index) {
                final feedItem = _feedItems![index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(feedItem.user.imageUrl),
                        ),
                        title: Text(
                          feedItem.user.fullName,
                          style: AppStyles.h4.copyWith(color: Colors.black),
                        ),
                        subtitle: Text(
                          feedItem.user.userName,
                          style: AppStyles.h5.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (bottomSheetDialog) {
                                return Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.save),
                                      title: const Text('Save'),
                                      onTap: () {
                                        Navigator.of(bottomSheetDialog).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.report),
                                      title: const Text('Report'),
                                      onTap: () {
                                        Navigator.of(bottomSheetDialog).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                      if (feedItem.content != null && feedItem.content != "")
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(feedItem.content!),
                        ),
                      if (feedItem.imageUrl != null &&
                          feedItem.imageUrl != "" &&
                          feedItem.imageUrl != "string")
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.network(feedItem.imageUrl!),
                        ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.thumb_up_alt_outlined),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.thumb_down_alt_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _AvatarImage extends StatelessWidget {
  final String url;
  const _AvatarImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: url != ""
          ? BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(url)))
          : const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryColor,
            ),
    );
  }
}

class _ActionsRow extends StatelessWidget {
  final FeedItem item;
  const _ActionsRow({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.grey, size: 18),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.grey),
          ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.mode_comment_outlined),
            label: Text(
                item.commentsCount == 0 ? '' : item.commentsCount.toString()),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
            label: Text(
                item.retweetsCount == 0 ? '' : item.retweetsCount.toString()),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
            label: Text(item.likesCount == 0 ? '' : item.likesCount.toString()),
          ),
        ],
      ),
    );
  }
}
