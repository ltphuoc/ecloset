import 'package:ecloset/Model/DAO/BaseDAO.dart';
import 'package:ecloset/Model/DTO/MetaDataDTO.dart';
import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/Utils/request.dart';

class ClosetDAO extends BaseDAO {
  Future<List<ClosetData>?> getClosets({
    int page = 1,
    int size = 10,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    List<ClosetData> closetList;
    final res = await request.get(
      'api/Product',
      queryParameters: {"page": page, "size": size}..addAll(params),
    );
    final jsonList = res.data['result']['data'];
    metaDataDTO = MetaDataDTO.fromJson(res.data["result"]['metadata']);
    if (jsonList != null) {
      closetList =
          List<ClosetData>.from(jsonList.map((i) => ClosetData.fromJson(i)));
      return closetList;
    }
    return null;
  }
}
