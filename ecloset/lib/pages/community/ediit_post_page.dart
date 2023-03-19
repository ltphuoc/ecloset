// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ecloset/utils/request.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Constant/app_colors.dart';
import '../../ViewModel/account_viewModel.dart';
import '../../constant/app_styles.dart';
import '../../utils/shared_pref.dart';
import '../../widgets/loading_screen.dart';
import 'newsfeed.dart';

class EditPostPage extends StatefulWidget {
  const EditPostPage({super.key, this.id});

  final int? id;

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _formKey = GlobalKey<FormState>();
  PostData? _post;
  String _postContent = "";
  Future<void> fetchPost() async {
    try {
      final res = await request.get("api/Post/${widget.id}");

      _post = PostData.fromJson(res.data['data']);
      _postContent = _post!.postContent!;
      setState(() {});
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    var account = Get.find<AccountViewModel>().account;
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: AppBar(
        title: const Text("Edit post"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actions: [
          Container(
              margin:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 4),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brown,
                    disabledBackgroundColor:
                        const Color.fromARGB(132, 217, 217, 217),
                  ),
                  onPressed: _postContent.trim() != ""
                      ? () async {
                          try {
                            loadingScreen(context);

                            var accountId = await getAccountId()
                                .then((value) => int.parse(value!));
                            final res = await request
                                .put("api/Post/${widget.id}", data: {
                              "postContent": _postContent.trim(),
                              "accountId": accountId,
                              "postImg": _post!.postImg
                            });

                            Navigator.of(context).pop();
                            if (res.statusCode != 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Can't edit post. Please try again")),
                              );
                            } else {
                              const SnackBar(content: Text("Updated"));
                              Navigator.of(context).pop();
                            }
                          } catch (e) {
                            if (kDebugMode) {
                              print(e.toString());
                            }
                          }
                        }
                      : null,
                  child: const Text("Save")))
        ],
      ),
      body: _post == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(account?.avatar ?? ""),
                      ),
                      title: Text(
                        "${account!.contactFname ?? ""} ${account.contactLname ?? ""}"
                            .trim(),
                        style: AppStyles.h4.copyWith(color: Colors.black),
                      ),
                      subtitle: Text(
                        account.email ?? "",
                        style: AppStyles.h5.copyWith(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            initialValue: _post!.postContent ?? "",
                            onChanged: (value) {
                              setState(() {
                                _postContent = value;
                              });
                            },
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Write something'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            width: double.infinity,
                            color: AppColors.greyBg,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Image.network(_post!.postImg!),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
