import 'package:dio/dio.dart';
import 'package:ecloset/Model/DAO/BaseDAO.dart';
import 'package:ecloset/Model/DTO/MetaDataDTO.dart';
import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/Utils/request.dart';

class OutFitDAO extends BaseDAO {
  Future<List<OutFitDTO>?> getOutFitList({
    int page = 1,
    int size = 10,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    List<OutFitDTO> outFitList;
    final res = await request.get(
      'api/Outfit',
      queryParameters: {"page": page, "size": size}..addAll(params),
    );
    final jsonList = res.data['data'];
    metaDataDTO = MetaDataDTO.fromJson(res.data['metadata']);
    if (jsonList != null) {
      outFitList =
          List<OutFitDTO>.from(jsonList.map((i) => OutFitDTO.fromJson(i)));
      return outFitList;
    }
    return null;
  }

  Future<OutFitDTO> saveOutfit(
      String outfitName, String image, String description) async {
    Response response = await request.post("api/Outfit", data: {
      "outfitId": 2,
      "outfitName": outfitName,
      "categoryId": 1,
      "subcategoryId": 1,
      "supplierId": 2,
      "image": image,
      "description": description
    });
    final jsonlist = response.data['data'];
    final closet = OutFitDTO.fromJson(jsonlist);
    return closet;
  }
}
