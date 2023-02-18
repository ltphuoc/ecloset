import 'package:ecloset/Utils/routes_name.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/Pages/closet_page.dart';
import 'package:ecloset/Widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: const MainAppBar(),
      endDrawer: const Drawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(children: const [
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: _Trending(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: _Brand(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: _MyCloset(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: _Recommend(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: _Collection(),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Recommend extends StatelessWidget {
  const _Recommend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Category",
          style: AppStyles.h2
              .copyWith(fontWeight: FontWeight.w700, color: (AppColors.black)),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 2 / 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 2 / 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 2 / 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _Collection extends StatelessWidget {
  const _Collection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Collection",
            style: AppStyles.h2.copyWith(
                fontWeight: FontWeight.w700, color: (AppColors.black)),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2 / 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 32,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2 / 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 32,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2 / 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Brand",
          style: AppStyles.h2
              .copyWith(fontWeight: FontWeight.w700, color: (AppColors.black)),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 2 / 2,
                child: Image.network(
                    "https://scontent.fsgn2-8.fna.fbcdn.net/v/t39.30808-6/331405420_724249545774216_6768026406247350442_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=1d2UpT6aYUcAX8Oo-ov&_nc_ht=scontent.fsgn2-8.fna&oh=00_AfBZSXhhpzbJyWcvw6Iz3QIWfHYEOBSdn11uQRylkZmNzg&oe=63F5D0E0"),
                //   [Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(100),
                //       color: Colors.grey,
                //     ),
                //   ),
                // ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 2 / 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 2 / 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 2 / 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _MyCloset extends StatelessWidget {
  const _MyCloset({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteName.closetPage);
          },
          child: Text(
            "My Closet",
            style: AppStyles.h2.copyWith(
                fontWeight: FontWeight.w700, color: (AppColors.black)),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 2 / 2,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    Image.network(
                        "https://scontent.fsgn2-8.fna.fbcdn.net/v/t39.30808-6/331405420_724249545774216_6768026406247350442_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=1d2UpT6aYUcAX8Oo-ov&_nc_ht=scontent.fsgn2-8.fna&oh=00_AfBZSXhhpzbJyWcvw6Iz3QIWfHYEOBSdn11uQRylkZmNzg&oe=63F5D0E0"),
                    Image.network(
                        "https://scontent.fsgn2-8.fna.fbcdn.net/v/t39.30808-6/331405420_724249545774216_6768026406247350442_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=1d2UpT6aYUcAX8Oo-ov&_nc_ht=scontent.fsgn2-8.fna&oh=00_AfBZSXhhpzbJyWcvw6Iz3QIWfHYEOBSdn11uQRylkZmNzg&oe=63F5D0E0"),
                    Image.network(
                        "https://scontent.fsgn2-8.fna.fbcdn.net/v/t39.30808-6/331405420_724249545774216_6768026406247350442_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=1d2UpT6aYUcAX8Oo-ov&_nc_ht=scontent.fsgn2-8.fna&oh=00_AfBZSXhhpzbJyWcvw6Iz3QIWfHYEOBSdn11uQRylkZmNzg&oe=63F5D0E0"),
                    Image.network(
                        "https://scontent.fsgn2-8.fna.fbcdn.net/v/t39.30808-6/331405420_724249545774216_6768026406247350442_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=1d2UpT6aYUcAX8Oo-ov&_nc_ht=scontent.fsgn2-8.fna&oh=00_AfBZSXhhpzbJyWcvw6Iz3QIWfHYEOBSdn11uQRylkZmNzg&oe=63F5D0E0")
                  ],
                ),

                // child: Container(
                //   // height: 150,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Colors.grey,
                //   ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _Trending extends StatelessWidget {
  const _Trending({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 12,
        ),
        AspectRatio(
          aspectRatio: 4 / 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
