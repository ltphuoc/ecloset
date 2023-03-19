import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/ViewModel/blogs_viewModel.dart';
import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/ViewModel/root_viewModel.dart';
import 'package:ecloset/ViewModel/startup_viewModel.dart';
import 'package:ecloset/Widgets/app_bar.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:ecloset/widgets/shimmer_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shimmer/shimmer.dart';

import 'closet/closet_page.dart';
import 'outfit/outfit.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<RootViewModel>().startUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      backgroundColor: AppColors.whiteBg,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverPadding(
              padding: EdgeInsets.only(top: 8),
              sliver: SliverToBoxAdapter(
                child: _Banner(),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(top: 12, left: 24, right: 24),
              sliver: SliverToBoxAdapter(
                child: _Brand(),
              ),
            ),
          ];
        },
        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TabBar(
                  indicatorColor: Colors.black,
                  labelStyle: AppStyles.h4,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Closet'),
                    Tab(text: 'Outfit'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      ScopedModel(
                          model: ClosetViewModel(),
                          child: ScopedModelDescendant<ClosetViewModel>(
                              builder: (context, child, model) {
                            var closetList =
                                Get.find<ClosetViewModel>().closetList ?? [];
                            if (closetList.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, left: 12, right: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        // Get.toNamed(RouteName.outfitPage);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ClosetPage(),
                                          ),
                                        ).then((_) {
                                          setState(() {
                                            // Call setState to refresh the page.
                                          });
                                        });
                                      },
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: AppColors.lightBrown1,
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(Icons.add),
                                                  Text("You don't have closet"),
                                                ],
                                              ),
                                            )),
                                      ),
                                    )),
                                    Expanded(child: Container()),
                                  ],
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 12, left: 12, right: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      Get.toNamed(RouteName.closetPage)
                                          ?.then((_) {
                                        setState(() {
                                          // Call setState to refresh the page.
                                        });
                                      });
                                    },
                                    child: AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: AppColors.lightBrown1,
                                        ),
                                        child: GridView.count(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          crossAxisCount: 2,
                                          children: closetList.length >= 4
                                              ? closetList
                                                  .sublist(0, 4)
                                                  .map(
                                                    (e) => Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              AppColors.whiteBg,
                                                          width: 0.7,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Image.network(
                                                          e.image ??
                                                              'https://picsum.photos/300',
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList()
                                              : closetList
                                                  .map(
                                                    (e) => Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              AppColors.whiteBg,
                                                          width: 0.7,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Image.network(
                                                          e.image ??
                                                              'https://picsum.photos/300',
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                        ),
                                      ),
                                    ),
                                  )),
                                  const SizedBox(width: 16),
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      Get.toNamed(RouteName.closetPage);
                                    },
                                    child: AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: AppColors.lightBrown1,
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.add),
                                                Text("Create a closet"),
                                              ],
                                            ),
                                          )),
                                    ),
                                  )),
                                ],
                              ),
                            );
                          })),
                      ScopedModel(
                        model: ClosetViewModel(),
                        child: ScopedModelDescendant<ClosetViewModel>(
                          builder: (context, child, model) {
                            var outFitList =
                                Get.find<ClosetViewModel>().outFitList ?? [];
                            if (outFitList.isEmpty) {}
                            return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12.0,
                                    mainAxisSpacing: 12.0,
                                    childAspectRatio: 366 / 512,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: outFitList.length,
                                  itemBuilder: (context, index) {
                                    final e = outFitList[
                                        outFitList.length - index - 1];
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 0.8,
                                        ),
                                      ),
                                      child: InkWell(
                                        child: Image.network(
                                          e.image ??
                                              'https://picsum.photos/300',
                                          fit: BoxFit.fill,
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => Outfit(
                                                index: index,
                                              ),
                                            ),
                                          ).then((value) {
                                            setState(() {
                                              // Call setState to refresh the page.
                                            });
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Outfit extends StatelessWidget {
  const _Outfit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ClosetViewModel(),
      child: ScopedModelDescendant<ClosetViewModel>(
        builder: (context, child, model) {
          var outFitList = Get.find<ClosetViewModel>().outFitList ?? [];
          if (outFitList.isEmpty) {}
          return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 366 / 512,
                ),
                scrollDirection: Axis.vertical,
                itemCount: outFitList.length,
                itemBuilder: (context, index) {
                  final e = outFitList[outFitList.length - index - 1];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 0.8,
                      ),
                    ),
                    child: InkWell(
                      child: Image.network(
                        e.image ?? 'https://picsum.photos/300',
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => Outfit(
                              index: index,
                            ),
                          ),
                        ).then(
                            (value) => Get.find<ClosetViewModel>().getOutfit());
                      },
                    ),
                  );
                },
              ));
        },
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({
    Key? key,
  }) : super(key: key);

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

class _Brand extends StatelessWidget {
  const _Brand({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
            height: 40,
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
