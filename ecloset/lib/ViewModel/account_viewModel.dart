import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/Model/DAO/AccountDAO.dart';
import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/ViewModel/base_model.dart';

class AccountViewModel extends BaseModel {
  AccountDAO? accountDAO;
  AccountDTO? account;

  AccountViewModel() {
    accountDAO = AccountDAO();
  }

  Future<void> getAccount(int accountId) async {
    try {
      setState(ViewStatus.Loading);
      account = await accountDAO?.getUser(accountId);
      // await Future.delayed(const Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } catch (e) {
      setState(ViewStatus.Error);
    }
  }
}
