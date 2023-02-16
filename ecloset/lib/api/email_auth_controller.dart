import 'package:email_auth/email_auth.dart';
import 'package:get/get.dart';

class EmailAuthorityController extends GetxController {
  EmailAuth emailAuth = EmailAuth(sessionName: "PRN231");
  var status = "".obs;

  Future<void> sendOTP(String email) async {
    var res = await emailAuth.sendOtp(recipientMail: email, otpLength: 6);
    if (res) {
      status.value = "OTP sent";
    } else {
      status.value = "sending failed";
    }
  }

  void validateOTP(String email, String otp) {
    var res = emailAuth.validateOtp(recipientMail: email, userOtp: otp);
    if (res) {
      status.value = "Verification success";
    } else {
      status.value = "wrong OTP";
    }
  }
}
