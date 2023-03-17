import 'package:ecloset/Model/DTO/ClosetDTO.dart';
import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../Utils/routes_name.dart';
import '../../constant/app_styles.dart';
import '../../utils/closet.dart';

class ClosetPage extends StatefulWidget {
  const ClosetPage({Key? key}) : super(key: key);

  @override
  State<ClosetPage> createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  int id = 1;
  // var _accountId;

  @override
  void initState() {
    super.initState();
    Get.find<ClosetViewModel>().getCloset();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ClosetViewModel(),
      child: ScopedModelDescendant<ClosetViewModel>(
        builder: (context, child, model) {
          var closetList = Get.find<ClosetViewModel>().closetList ?? [];

          List topIds, pantIds, footwearIds, otherIds;
          List categoryIds =
              closetList.map((closet) => closet.categoryId).toSet().toList();
          List subCategoryIds =
              closetList.map((closet) => closet.subcategoryId).toSet().toList();
          if (categoryIds.isNotEmpty) {
            categoryIds.add(0);
            categoryIds = categoryIds.toList()..sort();
          }
          if (subCategoryIds.isNotEmpty) {
            subCategoryIds.add(0);
            subCategoryIds = subCategoryIds.toList()..sort();
          }
          topIds = subCategoryIds.where((e) => e <= 7).toList();
          pantIds = subCategoryIds
              .where((e) => (e <= 12 && e >= 8) || e == 0)
              .toList();
          footwearIds = subCategoryIds
              .where((e) => (e <= 16 && e >= 13) || e == 0)
              .toList();
          otherIds = subCategoryIds
              .where((e) => (e <= 20 && e >= 17) || e == 0)
              .toList();
          if (closetList.isEmpty) {}
          return Scaffold(
            backgroundColor: AppColors.whiteBg,
            // appBar: const MainAppBar(),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "All clothes",
                style: AppStyles.h3,
              ),
              backgroundColor: AppColors.primaryColor,
            ),
            body: SafeArea(
                child: DefaultTabController(
              length: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const TabBar(
                    isScrollable: true,
                    indicatorColor: AppColors.primaryColor,
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        text: "All",
                      ),
                      Tab(
                        text: "Top",
                      ),
                      Tab(
                        text: "Pant",
                      ),
                      Tab(
                        text: "Footwear",
                      ),
                      Tab(
                        text: "Accessories",
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        GridView.count(
                            crossAxisCount: 3,
                            children: closetList
                                .map((e) => closetItemCard(e))
                                .toList()),
                        DefaultTabController(
                            animationDuration: Duration.zero,
                            length: topIds.length,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                      indicatorColor: Colors.transparent,
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.grey,
                                      isScrollable: true,
                                      tabs: topIds.map((e) {
                                        return Tab(
                                          text: getNameById(e, topBtn),
                                        );
                                      }).toList()),
                                ),
                                Expanded(
                                  child: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: topIds.map((subCatId) {
                                        return GridView.count(
                                            crossAxisCount: 3,
                                            children: closetList
                                                .where((e) {
                                                  if (subCatId != 0) {
                                                    return e.subcategoryId ==
                                                        subCatId;
                                                  }
                                                  return e.categoryId == 1;
                                                })
                                                .map((e) => closetItemCard(e))
                                                .toList());
                                      }).toList()),
                                )
                              ],
                            )),
                        DefaultTabController(
                            animationDuration: Duration.zero,
                            length: pantIds.length,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                      indicatorColor: Colors.transparent,
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.grey,
                                      isScrollable: true,
                                      tabs: pantIds.map((e) {
                                        return Tab(
                                          text: getNameById(e, pantBtn),
                                        );
                                      }).toList()),
                                ),
                                Expanded(
                                  child: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: pantIds.map((subCatId) {
                                        return GridView.count(
                                            crossAxisCount: 3,
                                            children: closetList
                                                .where((e) {
                                                  if (subCatId != 0) {
                                                    return e.subcategoryId ==
                                                        subCatId;
                                                  }
                                                  return e.categoryId == 2;
                                                })
                                                .map((e) => closetItemCard(e))
                                                .toList());
                                      }).toList()),
                                )
                              ],
                            )),
                        DefaultTabController(
                            animationDuration: Duration.zero,
                            length: footwearIds.length,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                      indicatorColor: Colors.transparent,
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.grey,
                                      isScrollable: true,
                                      tabs: footwearIds.map((e) {
                                        return Tab(
                                          text: getNameById(e, footwearBtn),
                                        );
                                      }).toList()),
                                ),
                                Expanded(
                                  child: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: footwearIds.map((subCatId) {
                                        return GridView.count(
                                            crossAxisCount: 3,
                                            children: closetList
                                                .where((e) {
                                                  if (subCatId != 0) {
                                                    return e.subcategoryId ==
                                                        subCatId;
                                                  }
                                                  return e.categoryId == 3;
                                                })
                                                .map((e) => closetItemCard(e))
                                                .toList());
                                      }).toList()),
                                )
                              ],
                            )),
                        DefaultTabController(
                            animationDuration: Duration.zero,
                            length: otherIds.length,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                      indicatorColor: Colors.transparent,
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.grey,
                                      isScrollable: true,
                                      tabs: otherIds.map((e) {
                                        return Tab(
                                          text: getNameById(e, otherBtn),
                                        );
                                      }).toList()),
                                ),
                                Expanded(
                                  child: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: otherIds.map((subCatId) {
                                        return GridView.count(
                                            crossAxisCount: 3,
                                            children: closetList
                                                .where((e) {
                                                  if (subCatId != 0) {
                                                    return e.subcategoryId ==
                                                        subCatId;
                                                  }
                                                  return e.categoryId == 4;
                                                })
                                                .map((e) => closetItemCard(e))
                                                .toList());
                                      }).toList()),
                                )
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
        },
      ),
    );
  }

  InkWell closetItemCard(ClosetData e) {
    return InkWell(
      onTap: () async {
        await Get.find<ClosetViewModel>().getCloset(e.productId);
        // Get.toNamed(RouteName.addEditItemPage, arguments: e.productId);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, RouteName.addEditItemPage,
                arguments: e.productId)
            .then((value) => setState(() {}));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(width: 0.1),
        ),
        child: Image.network(
          e.image ?? 'https://picsum.photos/300',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
