import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/Model/DAO/ClosetDAO.dart';
import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/ViewModel/base_model.dart';

class ClosetViewModel extends BaseModel {
  ClosetDAO? _closetDAO;
  List<ClosetDTO>? closetList;

  ClosetViewModel() {
    _closetDAO = ClosetDAO();
  }

  Future getCloset() async {
    try {
      setState(ViewStatus.Loading);
      closetList = await _closetDAO?.getClosets();
      setState(ViewStatus.Completed);
    } catch (e) {
      print(e);
      setState(ViewStatus.Error);
    }
  }
}
