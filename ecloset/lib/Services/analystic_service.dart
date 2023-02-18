import 'package:ecloset/Model/DTO/AccountDTO.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static AnalyticsService? _instance;

  static AnalyticsService? getInstance() {
    if (_instance == null) {
      _instance = AnalyticsService();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  // User properties tells us what the user is
  Future setUserProperties(AccountDTO user) async {
    await _analytics.setUserId(id: user.accountId.toString());
    await _analytics.setUserProperty(
      name: 'name',
      value: user.contactLname,
    );
    // await _analytics.setUserProperty(
    //   name: 'gender',
    //   value: user.gender.toString(),
    // );
    // await _analytics.setUserProperty(
    //   name: 'dayOfBirth',
    //   value: user.dateOfBirth.toString(),
    // );
    // property to indicate if it's a pro paying member
    // property that might tell us it's a regular poster, etc
  }

  Future logLogin(String method) async {
    await _analytics.logLogin(loginMethod: method);
  }

  Future logSignUp(String method) async {
    await _analytics.logSignUp(signUpMethod: method);
  }
}
