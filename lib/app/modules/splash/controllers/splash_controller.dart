import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 5), () {
      checkLogin();
    });
  }

  // function to return the 'token' from the shared preferences to navigate to the home page or login page
  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      Get.offNamed('/layout');
    } else {
      Get.offNamed('/auth');
    }
  }
}
