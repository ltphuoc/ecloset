import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/Model/DAO/ClosetDAO.dart';
import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/ViewModel/base_model.dart';

class ClosetViewModel extends BaseModel {
  ClosetDAO? closetDAO;
  List<ClosetData>? closetList;

  ClosetViewModel() {
    closetDAO = ClosetDAO();
  }

  Future<void> getCloset() async {
    try {
      setState(ViewStatus.Loading);
      final closets = await closetDAO?.getClosets();
      closetList = closets;
      // await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      print(e);
      setState(ViewStatus.Completed);
    }
  }
}
