import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
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
  int id = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: ClosetViewModel(),
        child: ScopedModelDescendant<ClosetViewModel>(
          builder: (context, child, model) {
            var outFitList = Get.find<ClosetViewModel>().outFitList;
            return Scaffold(
              backgroundColor: AppColors.whiteBg,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "My Outfit",
                  style: AppStyles.h3,
                ),
                backgroundColor: AppColors.primaryColor,
              ),
              body: SafeArea(
                child: SizedBox(
                  height: Get.height,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Column(children: [
                          (outFitList != null && outFitList.isNotEmpty)
                              ? GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 12.0,
                                          mainAxisSpacing: 12.0,
                                          childAspectRatio: 366 / 512),
                                  itemCount: outFitList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var outFit = outFitList[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteBg,
                                          border: Border.all(
                                              width: 0.5,
                                              color: AppColors.primaryColor)),
                                      child: InkWell(
                                        child: Image.network(
                                          outFit.image ??
                                              'https://picsum.photos/300',
                                          fit: BoxFit.fill,
                                        ),
                                        onTap: () {},
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
}
