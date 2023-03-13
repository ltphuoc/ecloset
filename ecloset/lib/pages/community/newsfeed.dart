import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class NewsFeedPage extends StatelessWidget {
  const NewsFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView.separated(
              itemCount: _feedItems.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                final item = _feedItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 50,
                                    child: _AvatarImage(item.user.imageUrl)),
                                const SizedBox(width: 12),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 16, 0, 0),
                                  child: Expanded(
                                      child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: item.user.fullName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: " @${item.user.userName}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ]),
                                  )),
                                ),
                              ],
                            ),
                            if (item.content != null)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                                child: Text(item.content!),
                              ),
                            if (item.imageUrl != "" && item.imageUrl != null)
                              Container(
                                height: 400,
                                margin: const EdgeInsets.only(top: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      item.imageUrl!,
                                    ),
                                  ),
                                ),
                              ),
                            _ActionsRow(item: item)
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
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
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(url))),
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

class FeedItem {
  final String? content;
  final String? imageUrl;
  final User user;
  final int commentsCount;
  final int likesCount;
  final int retweetsCount;

  FeedItem(
      {this.content,
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

  User(
    this.fullName,
    this.userName,
    this.imageUrl,
  );
}

final List<User> _users = [
  User(
    "Lê Bảo",
    "lebaopham",
    "",
  ),
  User(
    "Thanh Phuớc",
    "phuoc8ngon",
    "https://i.pinimg.com/736x/1b/04/2f/1b042fb20a1cb6e6804098108a1ee999.jpg",
  ),
  User(
    "Hiếu Kiên",
    "hiukien2602",
    "",
  ),
  User(
    "Anh Huy",
    "cavoi",
    "",
  ),
  User(
    "Hihi",
    "haha",
    "https://s.congtys.com/avatar/22G521D956-default.jpg",
  )
];

final List<FeedItem> _feedItems = [
  FeedItem(
    content: "Fashions fade, style is eterna",
    user: _users[0],
    imageUrl:
        "https://i.pinimg.com/564x/2c/d7/6b/2cd76bd2f04db9f28a8b6d184c09585b.jpg",
    likesCount: 100,
    commentsCount: 10,
    retweetsCount: 1,
  ),
  FeedItem(
      user: _users[4],
      imageUrl:
          "https://i.pinimg.com/236x/dc/e1/be/dce1be915b9d70fe44d9ee67be41b4ba.jpg",
      likesCount: 20,
      commentsCount: 15,
      retweetsCount: 12),
  FeedItem(
      user: _users[4],
      imageUrl:
          "https://i.pinimg.com/236x/16/38/9f/16389f4527b75a58f8d62d75bedc7cb8.jpg",
      likesCount: 20,
      commentsCount: 0,
      retweetsCount: 6),
  FeedItem(
      user: _users[1],
      imageUrl:
          "https://images.herzindagi.info/image/2022/Oct/HZ_style_main-liamtra-fashion.jpg",
      likesCount: 10,
      commentsCount: 2),
  FeedItem(
      user: _users[1],
      content:
          "Fashion is a form of ugliness so intolerable that we have to alter it every six months",
      imageUrl:
          "https://i.pinimg.com/564x/04/a7/48/04a748726a66ad745fdeed5023d52d36.jpg",
      likesCount: 500,
      commentsCount: 202,
      retweetsCount: 120),
  FeedItem(
    user: _users[2],
    content:
        "Don’t be into trends. Don’t make fashion own you, but you decide what you are, what you want to express by the way you dress and the way you live",
    imageUrl:
        "https://i.pinimg.com/736x/04/65/78/0465784c11d21bd41ce4ed499cc18a5e.jpg",
  ),
  FeedItem(
    user: _users[1],
    imageUrl:
        "https://i.pinimg.com/564x/81/a8/3d/81a83dc89c260fc85158ad860e67e000.jpg",
  ),
  FeedItem(
    user: _users[3],
    imageUrl:
        "https://i.pinimg.com/564x/26/c9/72/26c972da9804453955b03b5ebb803ef5.jpg",
  ),
  FeedItem(
    user: _users[0],
    imageUrl:
        "https://i.pinimg.com/564x/a9/9e/2b/a99e2b4e142034cb694bdeb037bd6d20.jpg",
  ),
];
