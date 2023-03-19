import 'dart:io';

import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/Model/DAO/ClosetDAO.dart' show ClosetDAO;
import 'package:ecloset/Model/DAO/OutFitDAO.dart';
import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/ViewModel/base_model.dart';
import 'package:ecloset/ViewModel/root_viewModel.dart';
import 'package:ecloset/widgets/loading_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../pages/app.dart';

class ClosetViewModel extends BaseModel {
  ClosetDAO? closetDAO;
  OutFitDAO? _dao;
  ClosetData? closet;
  OutFitDTO? outFit;
  List<OutFitDTO>? outFitList = [];
  List<ClosetData>? closetList;
  File? image;
  String? url;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  ClosetViewModel() {
    closetDAO = ClosetDAO();
    _dao = OutFitDAO();
  }

  Future<void> getCloset([int? id]) async {
    try {
      setState(ViewStatus.Loading);
      if (id != null) {
        closet = await closetDAO?.getCloset(id);
      } else {
        closetList = await closetDAO?.getClosetList();
      }

      // await Future.delayed(const Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      setState(ViewStatus.Error);
    }
  }

  Future<bool> deleteCloset(int id) async {
    try {
      setState(ViewStatus.Loading);
      await closetDAO?.deleteCloset(id);

      await Get.find<RootViewModel>().startUp();
      // await Future.delayed(const Duration(microseconds: 500));\
      setState(ViewStatus.Completed);
      return true;
    } catch (e) {
      setState(ViewStatus.Error);
      return false;
    }
  }

  Future<void> updateCloset(int productId, String productName, int proId,
      int proCat, String url) async {
    try {
      setState(ViewStatus.Loading);
      showLoading();
      String? checkUrl = closetList?.map((e) => e.image).toString();
      if (checkUrl == url) {
        url = '';
      }
      closet = await closetDAO?.updateCloset(
          productId, productName, proId, proCat, url);
      hideDialog();
      await Get.find<ClosetViewModel>().getCloset();
      // await Future.delayed(Duration(microseconds: 500));
      // Get.offAll(() => const App());
      setState(ViewStatus.Completed);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(ViewStatus.Error);
    }
  }

  Future<void> getOutfit([int? id]) async {
    try {
      setState(ViewStatus.Loading);
      if (id != null) {
        outFit = await _dao?.getOutfit(id);
      } else {
        outFitList = await _dao?.getOutFitList();
      }

      // await Future.delayed(const Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      setState(ViewStatus.Error);
    }
  }

  Future<void> addCloset(
      String productName, int proId, int proCat, String url) async {
    try {
      setState(ViewStatus.Loading);
      showLoading();
      String? checkUrl = closetList?.map((e) => e.image).toString();
      if (url == checkUrl) {
        url = '';
      }
      closet = await closetDAO?.addCloset(productName, proId, proCat, url);
      hideDialog();
      await Get.find<RootViewModel>().startUp();
      Get.offAll(() => const App());
      // await Future.delayed(Duration(microseconds: 500));
      // Get.offAll(() => const App());
      setState(ViewStatus.Completed);
    } catch (e) {
      setState(ViewStatus.Error);
    }
  }

  Future<void> saveOutfit(
      String outfitName, String img, String description) async {
    try {
      setState(ViewStatus.Loading);
      // showLoading();
      outFit = await _dao?.saveOutfit(outfitName, img, description);
      // hideDialog();

      await Get.find<RootViewModel>().startUp();
      Get.offAll(() => const App());
      setState(ViewStatus.Completed);
    } catch (e) {
      setState(ViewStatus.Error);
    }
  }
}
