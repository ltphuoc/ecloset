import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/Utils/routes_name.dart';
import 'package:ecloset/ViewModel/blogs_viewModel.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/Pages/closet_page.dart';
import 'package:ecloset/Widgets/app_bar.dart';
import 'package:ecloset/widgets/shimmer_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const MainAppBar(),
      endDrawer: const Drawer(),
      body: SafeArea(
        child: ListView(children: const [
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: banner(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24),
            child: _Brand(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24),
            child: _MyCloset(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24),
            child: _Recommend(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24),
            child: _Collection(),
          ),
        ]),
      ),
    );
  }
}

class banner extends StatelessWidget {
  const banner({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<BlogsViewModel>(
        model: BlogsViewModel(),
        child: Container(
          // color: Colors.white,
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          // padding: EdgeInsets.only(bottom: 8),
          child: ScopedModelDescendant<BlogsViewModel>(
            builder: (context, child, model) {
              ViewStatus status = model.status;
              switch (status) {
                case ViewStatus.Loading:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShimmerBlock(
                      height: (Get.width) * (747 / 1914),
                      width: (Get.width),
                    ),
                  );
                case ViewStatus.Empty:
                case ViewStatus.Error:
                  return SizedBox.shrink();
                default:
                  if (model.blogs == null || model.blogs.isEmpty) {
                    return SizedBox.shrink();
                  }
                  return Container(
                    height: (Get.width) * (747 / 1914),
                    width: (Get.width),
                    // margin: EdgeInsets.only(bottom: 8, top: 8),
                    child: Swiper(
                        onTap: (index) async {
                          // await launch(
                          //     "https://www.youtube.com/embed/wu32Wj_Uix4");
                        },
                        autoplay: model.blogs.length > 1 ? true : false,
                        autoplayDelay: 5000,
                        viewportFraction: 0.9,
                        pagination: new SwiperPagination(
                            alignment: Alignment.bottomCenter),
                        itemCount: model.blogs.length,
                        itemBuilder: (context, index) {
                          if (model.blogs[index]['images'] == null ||
                              model.blogs[index]['images'] == "")
                            return Icon(
                              MdiIcons.imageBroken,
                              color: AppColors.primaryColor.withOpacity(0.5),
                            );

                          return CachedNetworkImage(
                            imageUrl: model.blogs[index]['images'],
                            imageBuilder: (context, imageProvider) => InkWell(
                              onTap: () {
                                // Get.toNamed(RouteHandler.BANNER_DETAIL,
                                //     arguments: model.blogs[index]);
                              },
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                  margin: EdgeInsets.only(left: 8, right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: Container(
                                color: Colors.grey,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              MdiIcons.imageBroken,
                              color: AppColors.primaryColor.withOpacity(0.5),
                            ),
                          );
                        }),
                  );
              }
            },
          ),
        ));
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
      padding: const EdgeInsets.only(bottom: 40),
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



// class _Trending extends StatelessWidget {
//   const _Trending({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         const SizedBox(
//           height: 12,
//         ),
//         AspectRatio(
//           aspectRatio: 4 / 2,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.grey,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
