// ignore_for_file: use_build_context_synchronously

import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../Utils/request.dart';
import '../../utils/shared_pref.dart';
import '../../widgets/loading_screen.dart';
import 'newsfeed.dart';

class UserFeedPage extends StatefulWidget {
  const UserFeedPage({Key? key, this.index}) : super(key: key);
  final int? index;
  @override
  State<UserFeedPage> createState() => _UserFeedPageState();
}

class _UserFeedPageState extends State<UserFeedPage> {
  List<PostData>? _post;
  List<User>? _users;
  List<FeedItem>? _feedItems;
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> fetchPost() async {
    try {
      var accountId = await getAccountId().then((value) => int.parse(value!));

      final res = await request
          .get("api/Post", queryParameters: {"Page": 1, "PageSize": 100});

      final List<AccountResponse> accountResponses = List<AccountResponse>.from(
          res.data['data'].map<AccountResponse>(
              (post) => AccountResponse.fromJson(post['accountResponse'])));

      _users = accountResponses.map<User>((accountResponse) {
        return User(
          fullName:
              "${accountResponse.contactFname} ${accountResponse.contactLname}"
                  .trim(),
          userName: accountResponse.email ?? "",
          imageUrl: accountResponse.avatar ?? "",
        );
      }).toList();

      _post = res.data['data']
          .map<PostData>((post) => PostData.fromJson(post))
          .toList()
          .where((post) => post.accountResponse?.accountId == accountId)
          .toList();

      _feedItems = _post!
          .map<FeedItem>((postData) {
            final user = _users?.firstWhere(
              (user) =>
                  "${user.fullName} ${user.userName}" ==
                  "${postData.accountResponse?.contactFname} ${postData.accountResponse?.contactLname} ${postData.accountResponse?.email}",
            );

            return FeedItem(
              postId: postData.postId!,
              content: postData.postContent,
              user: User(
                fullName: user!.fullName.replaceAll("null", "").trim(),
                userName: user.userName,
                imageUrl: user.imageUrl,
              ),
              imageUrl: postData.postImg,
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
      key: _scaffoldKey,
      appBar: const MainAppBar(),
      backgroundColor: AppColors.whiteBg,
      body: _feedItems == null
          ? const Center(child: CircularProgressIndicator())
          : ScrollablePositionedList.builder(
              initialScrollIndex: widget.index ?? 0,
              itemPositionsListener: _itemPositionsListener,
              itemScrollController: _scrollController,
              itemCount: _feedItems!.length,
              itemBuilder: (_, int index) {
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
                                      leading: Icon(Icons.save),
                                      title: Text('Edit'),
                                      onTap: () {
                                        Navigator.of(bottomSheetDialog).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete'),
                                      onTap: () async {
                                        Navigator.of(bottomSheetDialog).pop();
                                        bool shouldDelete = await showDialog(
                                          context: bottomSheetDialog,
                                          builder: (dialogContext) {
                                            return AlertDialog(
                                              title: Text('Delete Post?'),
                                              content: Text(
                                                  'Are you sure you want to delete this post?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => Navigator.of(
                                                          dialogContext)
                                                      .pop(false),
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () => Navigator.of(
                                                          dialogContext)
                                                      .pop(true),
                                                  child: const Text("Delete"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        if (shouldDelete == true) {
                                          try {
                                            loadingScreen(context);
                                            final res = await request.delete(
                                                "api/Post/${feedItem.postId}");
                                            Navigator.of(context).pop();
                                            if (res.statusCode != 200) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content:
                                                        Text("Delete Failed")),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text("Deleted")),
                                              );
                                              fetchPost();
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Delete Failed.Please try again")),
                                            );
                                          }
                                        }
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
                          padding: const EdgeInsets.all(8),
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
