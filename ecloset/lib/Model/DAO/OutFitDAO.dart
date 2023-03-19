import 'package:dio/dio.dart';
import 'package:ecloset/Model/DAO/BaseDAO.dart';
import 'package:ecloset/Model/DTO/MetaDataDTO.dart';
import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/Utils/request.dart';

import '../../utils/shared_pref.dart';

class OutFitDAO extends BaseDAO {
  Future<OutFitDTO?> getOutfit(id) async {
    OutFitDTO outfit;
    final res = await request.get(
      "api/outfit/$id",
    );
    final jsonList = res.data['data'];
    if (jsonList != null) {
      outfit = OutFitDTO.fromJson(jsonList);

      return outfit;
    }
    return null;
  }

  Future<List<OutFitDTO>?> getOutFitList({
    int page = 1,
    int size = 100,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    List<OutFitDTO> outFitList;
    final res = await request.get(
      'api/Outfit',
      queryParameters: {"Page": page, "PageSize": size}..addAll(params),
    );
    final jsonList = res.data['data'];
    var accountId = await getAccountId().then((value) => int.parse(value!));
    metaDataDTO = MetaDataDTO.fromJson(res.data['metadata']);
    if (jsonList != null) {
      outFitList =
          List<OutFitDTO>.from(jsonList.map((i) => OutFitDTO.fromJson(i)))
              .where((element) => element.supplierId == accountId)
              .toList();
      return outFitList;
    }
    return null;
  }

  Future<OutFitDTO> saveOutfit(
      String outfitName, String image, String description) async {
    var accountId = await getAccountId().then((value) => int.parse(value!));
    Response response = await request.post("api/Outfit", data: {
      "outfitName": outfitName,
      "categoryId": 5,
      "subcategoryId": 1,
      "supplierId": accountId,
      "image": image,
      "description": description
    });
    final jsonlist = response.data['data'];
    final closet = OutFitDTO.fromJson(jsonlist);
    return closet;
  }
}
