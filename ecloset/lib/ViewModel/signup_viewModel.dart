import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/Model/DAO/AccountDAO.dart';
import 'package:ecloset/Model/DTO/AccountDTO.dart';
import 'package:ecloset/ViewModel/base_model.dart';

class SignUpViewModel extends BaseModel {
  AccountDAO? _accountDAO;
  AccountDTO? updateUser;
  SignUpViewModel() {
    _accountDAO = AccountDAO();
  }

  Future getCloset(AccountDTO user) async {
    try {
      setState(ViewStatus.Loading);
      updateUser = await _accountDAO?.updateUser(user);
      setState(ViewStatus.Completed);
    } catch (e) {
      print(e);
      setState(ViewStatus.Error);
    }
  }
}
