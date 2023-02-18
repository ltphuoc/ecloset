import 'package:ecloset/Model/DAO/index.dart';
import 'package:ecloset/Model/DTO/AccountDTO.dart';
import 'package:ecloset/Utils/shared_pref.dart';
import 'package:ecloset/ViewModel/base_model.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountViewModel extends BaseModel {
  AccountDAO? _dao;
  AccountDTO? currentUser;

  AccountViewModel() {
    _dao = AccountDAO();
  }

  Future<void> processSignout() async {
    // int option = await showOptionDialog("Mình sẽ nhớ bạn lắm ó huhu :'(((");
    await _dao?.logOut();
    await removeALL();
    Get.offAllNamed(RouteName.login);
  }
}
