import 'package:ecloset/Model/DAO/AccountDAO.dart';
import 'package:ecloset/Model/DTO/AccountDTO.dart';
import 'package:ecloset/Utils/routes_name.dart';
import 'package:ecloset/ViewModel/base_model.dart';
import 'package:ecloset/ViewModel/root_viewModel.dart';
import 'package:get/get.dart';

import '../utils/shared_pref.dart';

class StartUpViewModel extends BaseModel {
  StartUpViewModel() {
    handleStartUpLogic();
  }
  Future handleStartUpLogic() async {
    AccountDAO accountDAO = AccountDAO();
    await Future.delayed(const Duration(seconds: 3));
    var hasLoggedInUser = await accountDAO.isUserLoggedIn();

    // bool isFirstOnBoard = await getIsFirstOnboard() ?? true;

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
