import 'package:shared_preferences/shared_preferences.dart';

class CheckPremium {
  static Future<bool> checkSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ISBUY') ?? false;
  }
}
