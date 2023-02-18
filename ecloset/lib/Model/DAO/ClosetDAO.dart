import 'package:ecloset/Model/DAO/BaseDAO.dart';
import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/Utils/request.dart';

class ClosetDAO extends BaseDAO {
  Future<List<ClosetDTO>?> getClosets() async {
    List<ClosetDTO> closetList;
    final res = await request.get('Product');
    final jsonList = res.data['result']['data'];
    if (jsonList != null) {
      closetList =
          List<ClosetDTO>.from(jsonList.map((i) => ClosetDTO.fromJson(i)));
      return closetList;
    }
    return null;
  }
}
