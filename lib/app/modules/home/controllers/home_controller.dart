import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

// function to signout
  Future<void> signOut() async {
    // try catch block to handle the error
    try {
      isLoading.value = true;
      await supabase.auth.signOut();
      // remove the token from the shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      isLoading.value = false;
      Get.offAllNamed('/auth');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
