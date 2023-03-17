import 'package:ecloset/ViewModel/account_viewModel.dart';
import 'package:ecloset/ViewModel/base_model.dart';
import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:get/get.dart';

import '../utils/shared_pref.dart';

class RootViewModel extends BaseModel {
  Future startUp() async {
    var id = await getAccountId();
    int accountId = int.parse(id.toString());
    await Get.find<AccountViewModel>().getAccount(accountId);
    await Get.find<ClosetViewModel>().getCloset();
    await Get.find<ClosetViewModel>().getOutfit();
  }
}
