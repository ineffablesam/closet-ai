import 'package:closet_ai/main.dart';
import 'package:get/get.dart';

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
    final session = supabase.auth.currentSession;
    if (session != null) {
      Get.offNamed('/layout');
    } else {
      Get.offNamed('/auth');
    }
  }
}
