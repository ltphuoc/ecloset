import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecloset/Model/DAO/BaseDAO.dart';
import 'package:ecloset/Model/DTO/MetaDataDTO.dart';
import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/Utils/request.dart';
import 'package:ecloset/utils/shared_pref.dart';

class ClosetDAO extends BaseDAO {
  Future<ClosetData?> getCloset(id) async {
    ClosetData closet;
    final res = await request.get(
      "api/product/$id",
    );
    final jsonList = res.data['data'];
    if (jsonList != null) {
      closet = ClosetData.fromJson(jsonList);

      return closet;
    }
    return null;
  }

  Future<void> deleteCloset(int id) async {
    try {
      final res =
          await request.delete("api/product", queryParameters: {"id": id});
      if (res.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete product: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  Future<ClosetData>? updateCloset(int productId, String productName, int proId,
      int proCat, String picUrl) async {
    var accountId = await getAccountId().then((value) => int.parse(value!));
    try {
      Response response = await request.put("api/product", data: {
        "productId": productId,
        "productName": productName,
        "categoryId": proId,
        "subcategoryId": proCat,
        "supplierId": accountId,
        "color": "string",
        "image": picUrl,
        "productUrl": "string"
      });
      final jsonlist = response.data['data'];
      final closet = ClosetData.fromJson(jsonlist);

      return closet;
    } catch (e) {
      throw (e);
    }
  }

  Future<List<ClosetData>?> getClosetList({
    int page = 1,
    int size = 100,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    List<ClosetData> closetList;
    var accountId = await getAccountId().then((value) => int.parse(value!));
    final res = await request.get(
      'api/product',
      queryParameters: {"Page": page, "PageSize": size}..addAll(params),
    );
    final jsonList = res.data['result']['data'];
    metaDataDTO = MetaDataDTO.fromJson(res.data["result"]['metadata']);
    if (jsonList != null) {
      closetList =
          List<ClosetData>.from(jsonList.map((i) => ClosetData.fromJson(i)));
      List<ClosetData> closetList2 = closetList
          .where((e) => e.supplierId == accountId)
          .toList()
          .reversed
          .toList();
      return closetList2;
    }
    return null;
  }

  Future<ClosetData>? addCloset(
      String productName, int proId, int proCat, String picUrl) async {
    try {
      var accountId = await getAccountId().then((value) => int.parse(value!));
      Response response = await request.post("api/product", data: {
        "productName": productName,
        "categoryId": proId,
        "subcategoryId": proCat,
        "supplierId": accountId,
        "color": "string",
        "image": picUrl,
        "productUrl": "string"
      });
      final jsonlist = response.data['data'];
      final closet = ClosetData.fromJson(jsonlist);

      return closet;
    } catch (e) {
      throw (e);
    }
  }
}
