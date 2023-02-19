import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/ViewModel/blogs_viewModel.dart';
import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/Widgets/app_bar.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:ecloset/widgets/shimmer_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shimmer/shimmer.dart';

List images = ['assets/images/img1.png', "assets/images/img11.png"];
List imagess = ['assets/images/img2.png', "assets/images/tee.png"];

List brandList = [
  "https://cdn.logojoy.com/wp-content/uploads/2018/05/30171217/1253.png",
  "https://scontent.xx.fbcdn.net/v/t1.15752-9/312605451_368550622093275_6979727709408294604_n.png?stp=dst-png_p1080x2048&_nc_cat=108&ccb=1-7&_nc_sid=aee45a&_nc_ohc=KCTy2uEKoBAAX8zDY4Z&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdS376vjvFdjaoqYYkboLOeHjFdQ8O0TvXjDCv-G7t3VRw&oe=64184CD1",
  "https://scontent.xx.fbcdn.net/v/t1.15752-9/249849632_907607629858311_4690803459134502629_n.png?_nc_cat=107&ccb=1-7&_nc_sid=aee45a&_nc_ohc=q0DHoU6P0k0AX8LhBFo&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdQeSvJRr-sMU7_SJ8efQHsmkZ2_8d91ZyiCtPAlpQTVxA&oe=64184C18",
  "https://scontent.xx.fbcdn.net/v/t1.15752-9/277967988_303371048543646_549985502856049414_n.png?_nc_cat=105&ccb=1-7&_nc_sid=aee45a&_nc_ohc=V3tfnRkURGsAX8xI_gH&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdSFjVgR95uY0c9YWIW-2Tw0mf6i970qtjwC92vSJ5XsPA&oe=64183723",
  "https://scontent.xx.fbcdn.net/v/t1.15752-9/331201020_504977688464540_8597117485664390504_n.png?_nc_cat=106&ccb=1-7&_nc_sid=aee45a&_nc_ohc=im-dPDlmKH8AX-_Fs8h&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AdTLS5XrjxpKeoy_qw4RtAwr7N8pYjl-ug4hL3j83F6iFw&oe=641838A6",
  "https://cdn.logojoy.com/wp-content/uploads/2018/05/30171233/1044.png",
  "https://cdn.logojoy.com/wp-content/uploads/2018/05/30143359/2_big1.png"
];

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
      body: SafeArea(
        child: ListView(children: const [
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Banner(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4, left: 24, right: 24),
            child: _Brand(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24),
            child: _MyOutFIt(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
            child: _MyCloset(),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 24, left: 24, right: 24),
          //   child: _Recommend(),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(top: 24, left: 24, right: 24),
          //   child: _Collection(),
          // ),
        ]),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<BlogsViewModel>(
        model: BlogsViewModel(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                  return const SizedBox.shrink();
                default:
                  if (model.blogs == null || model.blogs.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return SizedBox(
                    height: (Get.width) * (747 / 1914),
                    width: (Get.width),
                    child: Swiper(
                        onTap: (index) async {
                          // await launch(
                          //     "https://www.youtube.com/embed/wu32Wj_Uix4");
                        },
                        autoplay: model.blogs.length > 1 ? true : false,
                        autoplayDelay: 5000,
                        viewportFraction: 0.9,
                        pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter),
                        itemCount: model.blogs.length,
                        itemBuilder: (context, index) {
                          if (model.blogs[index]['images'] == null ||
                              model.blogs[index]['images'] == "") {
                            return Icon(
                              MdiIcons.imageBroken,
                              color: AppColors.primaryColor.withOpacity(0.5),
                            );
                          }

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
                                  margin:
                                      const EdgeInsets.only(left: 8, right: 8),
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
        Container(
            margin: const EdgeInsets.only(top: 16),
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brandList.length,
              itemBuilder: (context, index) {
                String imageUrl = brandList[index];
                return Container(
                  margin: index != 0 ? const EdgeInsets.only(left: 16) : null,
                  child: ClipOval(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ))
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
            // Get.toNamed(RouteName.closetPage);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Outfits",
                style: AppStyles.h2.copyWith(
                    fontWeight: FontWeight.w700, color: (AppColors.black)),
              ),
              // ElevatedButton(
              //     style: ButtonStyle(
              //         backgroundColor:
              //             MaterialStatePropertyAll<Color>(Colors.white)),
              //     onPressed: () {
              //       Get.toNamed(RouteName.outfitPage);
              //     },
              //     child: Text(
              //       "Xem thêm",
              //       style: AppStyles.h3.copyWith(
              //           fontWeight: FontWeight.w600,
              //           color: AppColors.primaryColor,
              //           fontFamily: 'Nunito',
              //           fontSize: 12),
              //     )),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ScopedModel(
          model: ClosetViewModel(),
          child: ScopedModelDescendant<ClosetViewModel>(
            builder: (context, child, model) {
              var outFitList = Get.find<ClosetViewModel>().outFitList;
              bool hasLength = true;
              if (outFitList?.isEmpty == 0) {
                hasLength = false;
              }
              return Row(
                children: <Widget>[
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1 / 1.8,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        // itemCount: outFitList?.length,

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            // mainAxisExtent: 8,
                            // crossAxisSpacing: 8,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) => buildImage(
                            hasLength ? outFitList![0].image! : '', () {
                          Get.toNamed(RouteName.outfitDetail);
                        }),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1 / 1.8,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        // itemCount: outFitList?.length,

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            // mainAxisExtent: 8,
                            // crossAxisSpacing: 8,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) => buildImage(
                            hasLength ? null : outFitList![index].image!, () {
                          Get.toNamed(RouteName.outfitPage);
                        }),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

Widget buildImage(String? imgUrl, VoidCallback onPressed) {
  bool hasImg = true;
  if (imgUrl == null) {
    hasImg = false;
  }
  return InkWell(
    onTap: onPressed,
    child: Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: hasImg
              ? Image.network(
                  imgUrl!,
                  fit: BoxFit.fill,
                )
              : Center(
                  child: Text(
                    'View More',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
        ),
      ),
    ),
  );
}

class _MyOutFIt extends StatelessWidget {
  const _MyOutFIt({
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hot Outfits",
                style: AppStyles.h2.copyWith(
                    fontWeight: FontWeight.w700, color: (AppColors.black)),
              ),
              // ElevatedButton(
              //     style: ButtonStyle(
              //         backgroundColor: MaterialStatePropertyAll<Color>(
              //             AppColors.primaryColor)),
              //     onPressed: () {
              //       Get.toNamed(RouteName.outfitPage);
              //     },
              //     child: Text(
              //       "View your outfit",
              //       style: AppStyles.h3.copyWith(
              //           fontWeight: FontWeight.w600,
              //           color: Colors.white,
              //           fontFamily: 'Nunito',
              //           fontSize: 16),
              //     )),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white54,
                        ),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                    autoplay: true,
                    itemCount: images.length,
                  )),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white54,
                        ),
                        child: Image.asset(
                          imagess[index],
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                    autoplay: true,
                    autoplayDelay: 3500,
                    itemCount: imagess.length,
                  )),
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
