// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecloset/Model/DTO/ClosetDTO.dart';
import 'package:ecloset/Pages/save_outfit_page.dart';
import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_fonts.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../widgets/loading_screen.dart';
// import 'package:path_provider/path_provider.dart';

class SubCat {
  int id;
  String name;

  SubCat({required this.id, required this.name});
}

List<SubCat> topBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 1, name: "T-Shirt"),
  SubCat(id: 2, name: "Polo"),
  SubCat(id: 3, name: "Shirt"),
  SubCat(id: 4, name: "Jacket"),
  SubCat(id: 5, name: "Hoodie"),
  SubCat(id: 6, name: "Sweater"),
  SubCat(id: 7, name: "Blazer"),
];
List<SubCat> pantBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 8, name: "Short"),
  SubCat(id: 9, name: "Trousers"),
  SubCat(id: 10, name: "Jeans"),
  SubCat(id: 11, name: "Khaki"),
  SubCat(id: 12, name: "Cargo"),
];
List<SubCat> footwearBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 13, name: "Trainers"),
  SubCat(id: 14, name: "Sneakers"),
  SubCat(id: 15, name: "Boots"),
  SubCat(id: 16, name: "Sandals"),
];
List<SubCat> otherBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 17, name: "Hat"),
  SubCat(id: 18, name: "Glasses"),
  SubCat(id: 19, name: "Belt"),
  SubCat(id: 20, name: "Wallet"),
];

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
    screen = const Size(800, 600);

    _selectedTop = topBtn.first.id;
    _selectedPant = topBtn.first.id;
    _selectedFootwear = topBtn.first.id;
    _selectedOther = topBtn.first.id;
  }

//  ContainerList(
//         height: 150.0,
//         width: 150.0,
//         rotation: 0.0,
//         scale: 1.0,
//         xPosition: 0.1,
//         yPosition: 0.1,
//         url: "assets/images/tee.png"),)

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
                  padding: const EdgeInsets.all(40.0),
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
        builder: (ctx) => StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) =>
                  SingleChildScrollView(
                child: DefaultTabController(
                    length: 5, // length of tabs
                    initialIndex: 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const TabBar(
                            isScrollable: true,
                            labelColor: AppColors.secondaryColor,
                            indicatorColor: AppColors.secondaryColor,
                            unselectedLabelColor: Colors.black87,
                            tabs: [
                              Tab(
                                  child: Text(
                                "All",
                                style: TextStyle(
                                    fontFamily: AppFonts.nunito,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              )),
                              Tab(
                                  child: Text(
                                "Tops",
                                style: TextStyle(
                                    fontFamily: AppFonts.nunito,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              )),
                              Tab(
                                  child: Text(
                                "Pants",
                                style: TextStyle(
                                    fontFamily: AppFonts.nunito,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              )),
                              Tab(
                                  child: Text(
                                "Footwear",
                                style: TextStyle(
                                    fontFamily: AppFonts.nunito,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              )),
                              Tab(
                                  child: Text(
                                "Accessories",
                                style: TextStyle(
                                    fontFamily: AppFonts.nunito,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              )),
                            ],
                          ),
                          Container(
                              height: 400, //height of TabBarView
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.grey, width: 0.5))),
                              child: TabBarView(children: [
                                GridView.count(
                                    crossAxisCount: 3,
                                    children: closetList!
                                        .map((e) => InkWell(
                                              onTap: () {
                                                doMultiSelect(
                                                    e.image, setState);
                                              },
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.1),
                                                    ),
                                                    child: Image.network(
                                                        e.image ??
                                                            'https://picsum.photos/300',
                                                        fit: BoxFit.cover),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Icon(
                                                      list.any((element) =>
                                                              element.url ==
                                                              e.image)
                                                          ? Icons.check_circle
                                                          : Icons
                                                              .radio_button_unchecked,
                                                      size: 24,
                                                      color: AppColors
                                                          .secondaryColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                        .toList()),
                                Column(
                                  children: [
                                    Wrap(
                                      children: topBtn
                                          .map((e) => TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _selectedTop = e.id;
                                                });
                                              },
                                              child: Text(
                                                e.name,
                                                style: AppStyles.h4.copyWith(
                                                    color: _selectedTop == e.id
                                                        ? AppColors
                                                            .secondaryColor
                                                        : AppColors.textGrey),
                                              )))
                                          .toList(),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Expanded(
                                      child: GridView.count(
                                          crossAxisCount: 3,
                                          children: closetList
                                              .where((e) {
                                                if (_selectedTop != 0) {
                                                  return e.subcategoryId ==
                                                      _selectedTop;
                                                } else {
                                                  return e.categoryId == 1;
                                                }
                                              })
                                              .map((e) => InkWell(
                                                    onTap: () {
                                                      doMultiSelect(
                                                          e.image, setState);
                                                    },
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 0.1),
                                                          ),
                                                          child: Image.network(
                                                              e.image ??
                                                                  'https://picsum.photos/300',
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: Icon(
                                                            list.any((element) =>
                                                                    element
                                                                        .url ==
                                                                    e.image)
                                                                ? Icons
                                                                    .check_circle
                                                                : Icons
                                                                    .radio_button_unchecked,
                                                            size: 24,
                                                            color: AppColors
                                                                .secondaryColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                              .toList()),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Wrap(
                                      children: pantBtn
                                          .map((e) => TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _selectedPant = e.id;
                                                });
                                              },
                                              child: Text(
                                                e.name,
                                                style: AppStyles.h4.copyWith(
                                                    color: _selectedPant == e.id
                                                        ? AppColors
                                                            .secondaryColor
                                                        : AppColors.textGrey),
                                              )))
                                          .toList(),
                                    ),
                                    Expanded(
                                      child: GridView.count(
                                          crossAxisCount: 3,
                                          children: closetList
                                              .where((e) {
                                                if (_selectedPant != 0) {
                                                  return e.subcategoryId ==
                                                      _selectedPant;
                                                } else {
                                                  return e.categoryId == 2;
                                                }
                                              })
                                              .map((e) => InkWell(
                                                    onTap: () {
                                                      doMultiSelect(
                                                          e.image, setState);
                                                    },
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 0.1),
                                                          ),
                                                          child: Image.network(
                                                              e.image ??
                                                                  'https://picsum.photos/300',
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: Icon(
                                                            list.any((element) =>
                                                                    element
                                                                        .url ==
                                                                    e.image)
                                                                ? Icons
                                                                    .check_circle
                                                                : Icons
                                                                    .radio_button_unchecked,
                                                            size: 24,
                                                            color: AppColors
                                                                .secondaryColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                              .toList()),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Wrap(
                                      children: footwearBtn
                                          .map((e) => TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _selectedFootwear = e.id;
                                                });
                                              },
                                              child: Text(
                                                e.name,
                                                style: AppStyles.h4.copyWith(
                                                    color: _selectedFootwear ==
                                                            e.id
                                                        ? AppColors
                                                            .secondaryColor
                                                        : AppColors.textGrey),
                                              )))
                                          .toList(),
                                    ),
                                    Expanded(
                                      child: GridView.count(
                                          crossAxisCount: 3,
                                          children: closetList
                                              .where((e) {
                                                if (_selectedFootwear != 0) {
                                                  return e.subcategoryId ==
                                                      _selectedFootwear;
                                                } else {
                                                  return e.categoryId == 3;
                                                }
                                              })
                                              .map((e) => InkWell(
                                                    onTap: () {
                                                      doMultiSelect(
                                                          e.image, setState);
                                                    },
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 0.1),
                                                          ),
                                                          child: Image.network(
                                                              e.image ??
                                                                  'https://picsum.photos/300',
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: Icon(
                                                            list.any((element) =>
                                                                    element
                                                                        .url ==
                                                                    e.image)
                                                                ? Icons
                                                                    .check_circle
                                                                : Icons
                                                                    .radio_button_unchecked,
                                                            size: 24,
                                                            color: AppColors
                                                                .secondaryColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                              .toList()),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Wrap(
                                      children: otherBtn
                                          .map((e) => TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _selectedOther = e.id;
                                                });
                                              },
                                              child: Text(
                                                e.name,
                                                style: AppStyles.h4.copyWith(
                                                    color: _selectedOther ==
                                                            e.id
                                                        ? AppColors
                                                            .secondaryColor
                                                        : AppColors.textGrey),
                                              )))
                                          .toList(),
                                    ),
                                    Expanded(
                                      child: GridView.count(
                                          crossAxisCount: 3,
                                          children: closetList
                                              .where((e) {
                                                if (_selectedOther != 0) {
                                                  return e.subcategoryId ==
                                                      _selectedOther;
                                                } else {
                                                  return e.categoryId == 4;
                                                }
                                              })
                                              .map((e) => InkWell(
                                                    onTap: () {
                                                      doMultiSelect(
                                                          e.image, setState);
                                                    },
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 0.1),
                                                          ),
                                                          child: Image.network(
                                                              e.image ??
                                                                  'https://picsum.photos/300',
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: Icon(
                                                            list.any((element) =>
                                                                    element
                                                                        .url ==
                                                                    e.image)
                                                                ? Icons
                                                                    .check_circle
                                                                : Icons
                                                                    .radio_button_unchecked,
                                                            size: 24,
                                                            color: AppColors
                                                                .secondaryColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                              .toList()),
                                    ),
                                  ],
                                )
                              ]))
                        ])),
              ),
            ));
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
}
