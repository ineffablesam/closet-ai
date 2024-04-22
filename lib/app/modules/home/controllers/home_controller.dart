import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../models/gen_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isFetchingCloset = false.obs;
  RxList<Gen> gen = <Gen>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCloset();
  }

  Future<void> fetchCloset() async {
    debugPrint('Fetching Closet Data');
    try {
      isFetchingCloset.value = true;
      final response = await supabase
          .from('generations')
          .select()
          .eq('user_id', supabase.auth.currentUser!.id);

      final List<Gen> genList = [];
      if (response != null && (response as List).isNotEmpty) {
        final List<dynamic> dataList = response as List<dynamic>;
        for (final data in dataList) {
          genList.add(Gen.fromJson(data as Map<String, dynamic>));
        }
      }

      gen.value = genList;
      debugPrint('Closet Data Fetched');
      debugPrint('Gen Length: ${gen.value.first.getUrl}');
    } catch (e) {
      isFetchingCloset.value = false;
      Get.snackbar('Error', e.toString());
    } finally {
      isFetchingCloset.value = false;
    }
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
