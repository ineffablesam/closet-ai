import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;

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
