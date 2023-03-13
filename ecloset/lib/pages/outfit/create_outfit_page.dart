// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecloset/Model/DTO/ClosetDTO.dart';
import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/pages/outfit/save_outfit_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../utils/closet.dart';
import '../../widgets/loading_screen.dart';

class ContainerList {
  double height;
  double width;
  double scale;
  double rotation;
  double xPosition;
  double yPosition;
  String url;

  ContainerList({
    required this.height,
    required this.rotation,
    required this.scale,
    required this.width,
    required this.xPosition,
    required this.yPosition,
    required this.url,
  });
}

class CreateOutfitPage extends StatefulWidget {
  const CreateOutfitPage({Key? key}) : super(key: key);

  @override
  State<CreateOutfitPage> createState() => _CreateOutfitPageState();
}

class _CreateOutfitPageState extends State<CreateOutfitPage> {
  List list = [];
  late Offset _initPos;
  Offset _currentPos = const Offset(0, 0);
  late double _currentScale;
  late double _currentRotation;
  late Size screen;
  bool _isSelectItem = false;
  int? _selectedTop;
  int? _selectedPant;
  int? _selectedFootwear;
  int? _selectedOther;

  WidgetsToImageController controller = WidgetsToImageController();

  @override
  void initState() {
    super.initState();
    screen = const Size(800, 1080);

    _selectedTop = topBtn.first.id;
    _selectedPant = topBtn.first.id;
    _selectedFootwear = topBtn.first.id;
    _selectedOther = topBtn.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: ClosetViewModel(),
        child: ScopedModelDescendant<ClosetViewModel>(
          builder: (context, child, model) {
            var listCloset = Get.find<ClosetViewModel>().closetList;
            return Scaffold(
              backgroundColor: AppColors.primaryColor,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Outfit idea",
                  style: AppStyles.h3,
                ),
                backgroundColor: AppColors.primaryColor,
                actions: [
                  TextButton(
                      onPressed: () async {
                        loadingScreen(context);
                        Uint8List? imageByte = await controller.capture();
                        if (imageByte == null) return;
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SaveOutfitPage(imageByte: imageByte)));
                      },
                      child: Text(
                        "Next",
                        style: AppStyles.h5,
                      ))
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: AppColors.brown,
                child: const Icon(Icons.add),
                onPressed: () {
                  _showBottomSheet(context, listCloset);
                },
              ),
              body: GestureDetector(
                onTap: () {
                  setState(() {
                    _isSelectItem = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: WidgetsToImage(
                    controller: controller,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.whiteBg,
                      ),
                      child: Stack(
                        children: list.map((value) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSelectItem = true;
                                int index = list.indexOf(value);
                                if (index == -1) return;
                                list.add(list.removeAt(index));
                              });
                            },
                            onScaleStart: (details) {
                              _initPos = details.focalPoint;
                              _currentPos =
                                  Offset(value.xPosition, value.yPosition);
                              _currentScale = value.scale;
                              _currentRotation = value.rotation;
                            },
                            onScaleUpdate: (details) {
                              final delta = details.focalPoint - _initPos;
                              final left =
                                  (delta.dx / screen.width) + _currentPos.dx;
                              final top =
                                  (delta.dy / screen.height) + _currentPos.dy;

                              setState(() {
                                value.xPosition = Offset(left, top).dx;
                                value.yPosition = Offset(left, top).dy;
                                value.rotation =
                                    details.rotation + _currentRotation;
                                value.scale = details.scale * _currentScale;
                              });
                            },
                            child: Stack(
                              children: [
                                Positioned(
                                  left: value.xPosition * screen.width,
                                  top: value.yPosition * screen.height,
                                  child: Transform.scale(
                                    scale: value.scale,
                                    child: Transform.rotate(
                                      angle: value.rotation,
                                      child: SizedBox(
                                        height: value.height,
                                        width: value.width,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Listener(
                                              onPointerDown: (details) {
                                                _initPos = details.position;
                                                _currentPos = Offset(
                                                    value.xPosition,
                                                    value.yPosition);
                                                _currentScale = value.scale;
                                                _currentRotation =
                                                    value.rotation;
                                              },
                                              child: DottedBorder(
                                                color: value == list.last &&
                                                        _isSelectItem
                                                    ? Colors.black
                                                    : Colors.transparent,
                                                dashPattern: const [8, 8],
                                                strokeWidth: 2,
                                                borderType: BorderType.RRect,
                                                radius:
                                                    const Radius.circular(12),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  child: Column(
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      value == list.last &&
                                                              _isSelectItem
                                                          ? IconButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 56,
                                                                      top: 8,
                                                                      bottom:
                                                                          16),
                                                              icon: const Icon(
                                                                Icons.close,
                                                                size: 80,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  list.remove(
                                                                      value);
                                                                });
                                                              },
                                                              color: Colors.red,
                                                            )
                                                          : IconButton(
                                                              icon: const Icon(
                                                                size: 32,
                                                                Icons.close,
                                                              ),
                                                              onPressed: () {},
                                                              color: Colors
                                                                  .transparent,
                                                            ),
                                                      Image.network(
                                                        (value.url),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  void _showBottomSheet(
      BuildContext context, List<ClosetData>? closetList) async {
    await showModalBottomSheet(
        backgroundColor: AppColors.whiteBg,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          List topIds, pantIds, footwearIds, otherIds;
          List categoryIds =
              closetList!.map((closet) => closet.categoryId).toSet().toList();
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
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) =>
                SingleChildScrollView(
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
                        SizedBox(
                            height: 400, //height of TabBarView
                            child: TabBarView(children: [
                              GridView.count(
                                  crossAxisCount: 3,
                                  children: closetList
                                      .map((e) =>
                                          closetItemIcon(e, list, setState))
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
                                                        return e.categoryId ==
                                                            1;
                                                      })
                                                      .map((e) =>
                                                          closetItemIcon(e,
                                                              list, setState))
                                                      .toList());
                                            }).toList()),
                                      )
                                    ],
                                  )),
                              // Column(
                              //   children: [
                              //     Wrap(
                              //       children: topBtn
                              //           .map((e) => TextButton(
                              //               onPressed: () {
                              //                 setState(() {
                              //                   _selectedTop = e.id;
                              //                 });
                              //               },
                              //               child: Text(
                              //                 e.name,
                              //                 style: AppStyles.h4.copyWith(
                              //                     color: _selectedTop == e.id
                              //                         ? AppColors.secondaryColor
                              //                         : AppColors.textGrey),
                              //               )))
                              //           .toList(),
                              //     ),
                              //     const SizedBox(
                              //       height: 8,
                              //     ),
                              //     Expanded(
                              //       child: GridView.count(
                              //           crossAxisCount: 3,
                              //           children: closetList
                              //               .where((e) {
                              //                 if (_selectedTop != 0) {
                              //                   return e.subcategoryId ==
                              //                       _selectedTop;
                              //                 } else {
                              //                   return e.categoryId == 1;
                              //                 }
                              //               })
                              //               .map((e) => InkWell(
                              //                     onTap: () {
                              //                       doMultiSelect(
                              //                           e.image, setState);
                              //                     },
                              //                     child: Stack(
                              //                       fit: StackFit.expand,
                              //                       children: [
                              //                         Container(
                              //                           decoration:
                              //                               BoxDecoration(
                              //                             border: Border.all(
                              //                                 width: 0.1),
                              //                           ),
                              //                           child: Image.network(
                              //                               e.image ??
                              //                                   'https://picsum.photos/300',
                              //                               fit: BoxFit.cover),
                              //                         ),
                              //                         Positioned(
                              //                           top: 0,
                              //                           right: 0,
                              //                           child: Icon(
                              //                             list.any((element) =>
                              //                                     element.url ==
                              //                                     e.image)
                              //                                 ? Icons
                              //                                     .check_circle
                              //                                 : Icons
                              //                                     .radio_button_unchecked,
                              //                             size: 24,
                              //                             color: AppColors
                              //                                 .secondaryColor,
                              //                           ),
                              //                         )
                              //                       ],
                              //                     ),
                              //                   ))
                              //               .toList()),
                              //     ),
                              //   ],
                              // ),

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
                                                        return e.categoryId ==
                                                            2;
                                                      })
                                                      .map((e) =>
                                                          closetItemIcon(e,
                                                              list, setState))
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
                                                text:
                                                    getNameById(e, footwearBtn),
                                              );
                                            }).toList()),
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            children:
                                                footwearIds.map((subCatId) {
                                              return GridView.count(
                                                  crossAxisCount: 3,
                                                  children: closetList
                                                      .where((e) {
                                                        if (subCatId != 0) {
                                                          return e.subcategoryId ==
                                                              subCatId;
                                                        }
                                                        return e.categoryId ==
                                                            3;
                                                      })
                                                      .map((e) =>
                                                          closetItemIcon(e,
                                                              list, setState))
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
                                                        return e.categoryId ==
                                                            4;
                                                      })
                                                      .map((e) =>
                                                          closetItemIcon(e,
                                                              list, setState))
                                                      .toList());
                                            }).toList()),
                                      )
                                    ],
                                  )),
                            ]))
                      ])),
            ),
          );
        });
  }

  void doMultiSelect(image, setStateBottom) {
    var item = ContainerList(
        height: 150.0,
        width: 150.0,
        rotation: 0.0,
        scale: 1.0,
        xPosition: 0.1,
        yPosition: 0.1,
        url: image);

    final newList = [...list];
    if (newList.any((element) => element.url == item.url)) {
      newList.removeWhere((element) => element.url == item.url);
    } else {
      newList.add(item);
    }
    setState(() {
      list = newList;
    });
    setStateBottom(() {});
  }

  InkWell closetItemIcon(ClosetData e, List list, setState) {
    return InkWell(
      onTap: () {
        doMultiSelect(e.image, setState);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.1),
            ),
            child: Image.network(e.image ?? 'https://picsum.photos/300',
                fit: BoxFit.cover),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Icon(
              list.any((element) => element.url == e.image)
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              size: 24,
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
