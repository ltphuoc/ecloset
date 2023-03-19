// ignore_for_file: use_build_context_synchronously

import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../Model/DTO/OutFitDTO.dart';
import '../../Utils/request.dart';
import '../../ViewModel/account_viewModel.dart';
import '../../utils/shared_pref.dart';
import '../../widgets/loading_screen.dart';
import 'edit_outfit_page.dart';

class Outfit extends StatefulWidget {
  const Outfit({Key? key, this.index}) : super(key: key);

  final int? index;

  @override
  State<Outfit> createState() => _OutfitState();
}

class _OutfitState extends State<Outfit> {
  List<OutFitDTO>? _outfit;

  final ItemScrollController _scrollController = ItemScrollController();

  Future<void> fetchOutfit() async {
    try {
      final res = await request
          .get("api/Outfit", queryParameters: {"Page": 1, "PageSize": 100});

      final jsonList = res.data['data'];
      var accountId = await getAccountId().then((value) => int.parse(value!));

      if (jsonList != null) {
        _outfit =
            List<OutFitDTO>.from(jsonList.map((i) => OutFitDTO.fromJson(i)))
                .where((element) => element.supplierId == accountId)
                .toList();
      }

      setState(() {});
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }

  @override
  initState() {
    super.initState();
    fetchOutfit();
  }

  @override
  Widget build(BuildContext context) {
    var account = Get.find<AccountViewModel>().account;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "All outfit",
          style: AppStyles.h3,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: AppColors.whiteBg,
      body: _outfit == null
          ? const Center(child: CircularProgressIndicator())
          : ScrollablePositionedList.builder(
              initialScrollIndex: widget.index ?? 0,
              itemScrollController: _scrollController,
              itemCount: _outfit!.length,
              itemBuilder: (context, int index) {
                final outfitItem = _outfit![index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(account?.avatar ?? ""),
                        ),
                        title: Text(
                          "${account?.contactLname} ${account?.contactFname ?? ""}",
                          style: AppStyles.h4.copyWith(color: Colors.black),
                        ),
                        subtitle: Text(
                          "${account?.email}",
                          style: AppStyles.h5.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (bottomSheetDialog) {
                                return Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.edit),
                                      title: const Text('Edit'),
                                      onTap: () {
                                        Navigator.of(bottomSheetDialog).pop();
                                        Get.to(() => EditOutfitPage(
                                                id: outfitItem.outfitId))!
                                            .then((value) {
                                          fetchOutfit();
                                        });
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.delete),
                                      title: const Text('Delete'),
                                      onTap: () async {
                                        Navigator.of(bottomSheetDialog).pop();
                                        bool shouldDelete = await showDialog(
                                          context: bottomSheetDialog,
                                          builder: (dialogContext) {
                                            return AlertDialog(
                                              title: const Text('Delete Post?'),
                                              content: const Text(
                                                  'Are you sure you want to delete this post?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => Navigator.of(
                                                          dialogContext)
                                                      .pop(false),
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () => Navigator.of(
                                                          dialogContext)
                                                      .pop(true),
                                                  child: const Text("Delete"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        if (shouldDelete == true) {
                                          try {
                                            loadingScreen(context);
                                            final res = await request.delete(
                                                "api/Outfit/${outfitItem.outfitId}");
                                            Navigator.of(context).pop();
                                            if (res.statusCode != 200) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content:
                                                        Text("Delete Failed")),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text("Deleted")),
                                              );
                                              fetchOutfit();
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Delete Failed.Please try again")),
                                            );
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        child: Text(
                          "Name: ${outfitItem.outfitName}",
                          style: AppStyles.h5.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      if (outfitItem.description != null &&
                          outfitItem.description != "")
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 8),
                          child: Text(
                            "Description: ${outfitItem.description}",
                            style: AppStyles.h5.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      if (outfitItem.image != null &&
                          outfitItem.image != "" &&
                          outfitItem.image != "string")
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.network(outfitItem.image!),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
