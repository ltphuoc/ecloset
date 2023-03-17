import 'dart:developer';

import 'package:ecloset/Constant/view_status.dart';
import 'package:ecloset/Model/DAO/AccountDAO.dart';
import 'package:ecloset/Model/DTO/AccountDTO.dart';
import 'package:ecloset/Services/analystic_service.dart';
import 'package:ecloset/Utils/routes_name.dart';
import 'package:ecloset/ViewModel/base_model.dart';
import 'package:ecloset/ViewModel/root_viewModel.dart';
import 'package:ecloset/widgets/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends BaseModel {
  late AccountDAO dao = AccountDAO();
  late String verificationId;
  late AnalyticsService _analyticsService;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late AccountDTO userInfo;

  LoginViewModel() {
    _analyticsService = AnalyticsService.getInstance()!;
  }

  Future<void> signInWithGoogle() async {
    try {
      setState(ViewStatus.Loading);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        showLoading();
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await _auth.signInWithCredential(credential);

        User userToken = FirebaseAuth.instance.currentUser!;
        final idToken = await userToken.getIdToken();
        // final fcmToken = await FirebaseMessaging.instance.getToken();
        userInfo = await dao.login(idToken);
        await _analyticsService.setUserProperties(userInfo);
        hideDialog();
        await Get.find<RootViewModel>().startUp();
        await Get.offAllNamed(RouteName.app);
      }
      await Future.delayed(Duration(microseconds: 500));
      setState(ViewStatus.Completed);
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      // });
      setState(ViewStatus.Completed);
    }
  }
}
