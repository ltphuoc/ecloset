import 'dart:convert';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/pages/closet_page.dart';
import 'package:ecloset/pages/save_outfit_page.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:widgets_to_image/widgets_to_image.dart';
// import 'package:path_provider/path_provider.dart';

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
  List<Closet> closetList = [];
  late Offset _initPos;
  Offset _currentPos = const Offset(0, 0);
  late double _currentScale;
  late double _currentRotation;
  late Size screen;
  bool _isSelectItem = false;

  WidgetsToImageController controller = WidgetsToImageController();

  void fetchClosets() async {
    try {
      const url = 'https://localhost:7269/api/product/list';
      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      setState(() {
        closetList = List<Closet>.from(json.map((i) => Closet.fromJson(i)));
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    screen = const Size(800, 600);
    fetchClosets();
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
                Uint8List? imageByte = await controller.capture();
                if (imageByte == null) return;
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
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          _showBottomSheet(context);
        },
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isSelectItem = false;
          });
        },
        child: WidgetsToImage(
          controller: controller,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.greyBg,
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
                    _currentPos = Offset(value.xPosition, value.yPosition);
                    _currentScale = value.scale;
                    _currentRotation = value.rotation;
                  },
                  onScaleUpdate: (details) {
                    final delta = details.focalPoint - _initPos;
                    final left = (delta.dx / screen.width) + _currentPos.dx;
                    final top = (delta.dy / screen.height) + _currentPos.dy;

                    setState(() {
                      value.xPosition = Offset(left, top).dx;
                      value.yPosition = Offset(left, top).dy;
                      value.rotation = details.rotation + _currentRotation;
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
                                          value.xPosition, value.yPosition);
                                      _currentScale = value.scale;
                                      _currentRotation = value.rotation;
                                    },
                                    child: DottedBorder(
                                      color: value == list.last && _isSelectItem
                                          ? Colors.black
                                          : Colors.transparent,
                                      dashPattern: const [8, 8],
                                      strokeWidth: 2,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: value == list.last &&
                                                        _isSelectItem
                                                    ? IconButton(
                                                        icon: const Icon(
                                                          Icons.close,
                                                          size: 32,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            list.remove(value);
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
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                            Image.memory(
                                              base64Decode(value.url),
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
    );
  }

  void _showBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) =>
                  SingleChildScrollView(
                child: DefaultTabController(
                    length: 3, // length of tabs
                    initialIndex: 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const TabBar(
                            labelColor: Colors.green,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(text: 'All'),
                              Tab(text: 'Tops'),
                              Tab(text: 'Pants'),
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
                                    children: closetList
                                        .map((e) => InkWell(
                                              onTap: () {
                                                doMultiSelect(
                                                    e.image, setState);
                                              },
                                              child: Stack(
                                                alignment: Alignment.topLeft,
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
                                                  Icon(
                                                    list.any((element) =>
                                                            element.url ==
                                                            e.image)
                                                        ? Icons.check_circle
                                                        : Icons
                                                            .radio_button_unchecked,
                                                    size: 24,
                                                    color:
                                                        AppColors.primaryColor,
                                                  )
                                                ],
                                              ),
                                            ))
                                        .toList()),
                                const Center(
                                  child: Text('Tops',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const Center(
                                  child: Text('Pants',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ),
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
