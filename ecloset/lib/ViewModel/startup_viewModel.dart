import 'package:ecloset/Model/DAO/AccountDAO.dart';
import 'package:ecloset/Utils/routes_name.dart';
import 'package:ecloset/Utils/shared_pref.dart';
import 'package:ecloset/ViewModel/base_model.dart';
import 'package:ecloset/ViewModel/root_viewModel.dart';
import 'package:get/get.dart';

class StartUpViewModel extends BaseModel {
  StartUpViewModel() {
    handleStartUpLogic();
  }
  Future handleStartUpLogic() async {
    AccountDAO _accountDAO = AccountDAO();
    await Future.delayed(Duration(seconds: 3));
    var hasLoggedInUser = await _accountDAO.isUserLoggedIn();
    bool isFirstOnBoard = await getIsFirstOnboard() ?? true;
    // if (isFirstOnBoard) {
    //   await Get.find<RootViewModel>().startUp();
    //   // Get.offAndToNamed(Rout.ONBOARD);
    // } else if (hasLoggedInUser) {
    //   await Get.find<RootViewModel>().startUp();
    //   Get.offAndToNamed(RouteName.NAV);
    // } else {
    //   Get.offAndToNamed(RouteName.login);
    // }
    if (hasLoggedInUser) {
      await Get.find<RootViewModel>().startUp();
      Get.offAndToNamed(RouteName.app);
    } else {
      Get.offAndToNamed(RouteName.login);
    }
  }
}
