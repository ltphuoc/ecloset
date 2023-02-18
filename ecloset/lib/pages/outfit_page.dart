import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

import '../utils/routes_name.dart';

class OutfitPage extends StatefulWidget {
  const OutfitPage({super.key});

  @override
  State<OutfitPage> createState() => _OutfitPageState();
}

class _OutfitPageState extends State<OutfitPage> {
  // List<Closet> closetList = [];
  int id = 1;
  @override
  void initState() {
    super.initState();
    fetchClosets();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: ClosetViewModel(),
        child: ScopedModelDescendant<ClosetViewModel>(
          builder: (context, child, model) {
            var outFitList = Get.find<ClosetViewModel>().outFitList;
            return Scaffold(
              backgroundColor: AppColors.primaryColor,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "My Outfit",
                  style: AppStyles.h3,
                ),
                backgroundColor: AppColors.primaryColor,
              ),
              body: SafeArea(
                child: Container(
                  height: Get.height,
                  color: Colors.grey.shade100,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(children: [
                          (outFitList != null && outFitList.isNotEmpty)
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16.0,
                                    mainAxisSpacing: 16.0,
                                  ),
                                  itemCount: outFitList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var outFit = outFitList[index];
                                    return Card(
                                      child: InkWell(
                                        child: Image.network(outFit.image ??
                                            'https://picsum.photos/300'),
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteName.addEditItemPage,
                                              arguments: outFit);
                                        },
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox(),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  void fetchClosets() async {
    // try {
    //   const url = 'https://localhost:7269/api/product/list';
    //   final response = await http.get(Uri.parse(url));
    //   final json = jsonDecode(response.body);
    //   setState(() {
    //     closetList = List<Closet>.from(json.map((i) => Closet.fromJson(i)));
    //   });
    // } on Exception catch (e) {
    //   print(e.toString());
    // }
  }
}
