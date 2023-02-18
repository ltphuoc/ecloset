import 'dart:io';

import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/Model/DAO/ClosetDAO.dart';
import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/ViewModel/base_model.dart';
import 'package:ecloset/ViewModel/login_viewModel.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ClosetViewModel extends BaseModel {
  AccountDTO? acc;
  ClosetDAO? closetDAO;
  ClosetData? closet;
  List<ClosetData>? closetList;
  File? image;
  String? url;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  ClosetViewModel() {
    closetDAO = ClosetDAO();
  }

  Future<void> getCloset() async {
    try {
      setState(ViewStatus.Loading);
      closetList = await closetDAO?.getClosets();

      // await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      print(e);
      setState(ViewStatus.Error);
    }
  }

  Future<void> addCloset(
      String productName, int proId, int proCat, String url) async {
    try {
      setState(ViewStatus.Loading);
      var checkUrl = closetList?.map((e) => e.image);
      if (checkUrl == url) {
        url = '';
      }
      closet = await closetDAO?.addCloset(productName, proId, proCat, url);
      // await Future.delayed(Duration(microseconds: 500));
      Get.toNamed(RouteName.app);
      setState(ViewStatus.Completed);
    } catch (e) {
      print(e);
      setState(ViewStatus.Error);
    }
  }
}
