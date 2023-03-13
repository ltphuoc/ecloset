import 'dart:io';

import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/Model/DAO/ClosetDAO.dart';
import 'package:ecloset/Model/DAO/OutFitDAO.dart';
import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/ViewModel/base_model.dart';
import 'package:ecloset/ViewModel/root_viewModel.dart';
import 'package:ecloset/pages/app.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:ecloset/widgets/loading_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';

class ClosetViewModel extends BaseModel {
  // AccountDTO? acc;
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

  Future<void> getCloset() async {
    try {
      setState(ViewStatus.Loading);
      closetList = await closetDAO?.getClosetList();

      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      print(e);
      setState(ViewStatus.Error);
    }
  }

  Future<void> getOutfitList() async {
    try {
      setState(ViewStatus.Loading);
      outFitList = await _dao?.getOutFitList();

      await Future.delayed(Duration(microseconds: 500));
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
      showLoading();
      var checkUrl = closetList?.map((e) => e.image);
      if (checkUrl == url) {
        url = '';
      }
      closet = await closetDAO?.addCloset(productName, proId, proCat, url);
      hideDialog();
      await Get.find<RootViewModel>().startUp();
      // await Future.delayed(Duration(microseconds: 500));
      Get.offAll(() => App());
      setState(ViewStatus.Completed);
    } catch (e) {
      print(e);
      setState(ViewStatus.Error);
    }
  }

  Future<void> saveOutfit(
      String outfitName, String img, String description) async {
    try {
      setState(ViewStatus.Loading);
      showLoading();
      outFit = await _dao?.saveOutfit(outfitName, img, description);
      hideDialog();
      outFitList?.add(OutFitDTO(
          outfitId: outFit?.outfitId,
          categoryId: outFit?.categoryId,
          description: outFit?.description,
          image: outFit?.image,
          outfitName: outFit?.outfitName,
          subcategoryId: outFit?.subcategoryId,
          supplierId: outFit?.supplierId));
      Get.toNamed(RouteName.outfitPage);
      setState(ViewStatus.Completed);
    } catch (e) {
      print(e);
      setState(ViewStatus.Error);
    }
  }
}
