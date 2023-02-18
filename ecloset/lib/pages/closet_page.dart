import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

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

class ClosetPage extends StatefulWidget {
  const ClosetPage({Key? key}) : super(key: key);

  @override
  State<ClosetPage> createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  int id = 1;
  int? _selectedTop;
  int? _selectedPant;
  int? _selectedFootwear;
  int? _selectedOther;
  @override
  void initState() {
    super.initState();
    Get.find<ClosetViewModel>().getCloset();
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
          var closetList = Get.find<ClosetViewModel>().closetList ?? [];
          if (closetList.isEmpty) {}
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: const MainAppBar(),
            body: SafeArea(
                child: DefaultTabController(
              length: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 8),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ButtonsTabBar(
                        buttonMargin: const EdgeInsets.all(8.0),
                        backgroundColor: AppColors.brown,
                        unselectedBackgroundColor: AppColors.primaryColor,
                        unselectedLabelStyle: AppStyles.h4,
                        labelStyle: AppStyles.h4,
                        tabs: const [
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
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        GridView.count(
                            crossAxisCount: 3,
                            children: closetList
                                .map((e) => InkWell(
                                      onTap: () {
                                        // doMultiSelect(e.image, setState);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.1),
                                        ),
                                        child: Image.network(
                                            e.image ??
                                                'https://picsum.photos/300',
                                            fit: BoxFit.cover),
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
                                                ? AppColors.brown
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
                                              // doMultiSelect(
                                              //     e.image, setState);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 0.1),
                                              ),
                                              child: Image.network(
                                                  e.image ??
                                                      'https://picsum.photos/300',
                                                  fit: BoxFit.cover),
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
                                                ? AppColors.brown
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
                                              // doMultiSelect(
                                              //     e.image, setState);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 0.1),
                                              ),
                                              child: Image.network(
                                                  e.image ??
                                                      'https://picsum.photos/300',
                                                  fit: BoxFit.cover),
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
                                            color: _selectedFootwear == e.id
                                                ? AppColors.brown
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
                                              // doMultiSelect(
                                              //     e.image, setState);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 0.1),
                                              ),
                                              child: Image.network(
                                                  e.image ??
                                                      'https://picsum.photos/300',
                                                  fit: BoxFit.cover),
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
                                            color: _selectedOther == e.id
                                                ? AppColors.brown
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
                                              // doMultiSelect(
                                              //     e.image, setState);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 0.1),
                                              ),
                                              child: Image.network(
                                                  e.image ??
                                                      'https://picsum.photos/300',
                                                  fit: BoxFit.cover),
                                            ),
                                          ))
                                      .toList()),
                            ),
                          ],
                        )
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

  // void fetchClosets() async {
  //   try {
  //     const url = 'https://localhost:7269/api/product/list';
  //     final response = await http.get(Uri.parse(url));
  //     final json = jsonDecode(response.body);
  //     setState(() {
  //       closetList = List<Closet>.from(json.map((i) => Closet.fromJson(i)));
  //     });
  //   } on Exception catch (e) {
  //     print(e.toString());
  //   }
  // }
}
