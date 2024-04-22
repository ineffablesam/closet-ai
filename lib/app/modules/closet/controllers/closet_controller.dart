import 'dart:async';
import 'dart:convert';

import 'package:closet_ai/app/models/final_gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/consts.dart';

class ClosetController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isGenerated = false.obs;
  Rx<FinalGen> finalGen = FinalGen().obs;

  Future<void> fetchCloset(String get) async {
    debugPrint('Fetching New Closet Data');
    try {
      // isLoading.value = true;
      final response = await http.get(
        Uri.parse(get),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $REPLICATE_KEY',
        },
      );
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${jsonDecode(response.body)}');
      if (response.statusCode == 200) {
        // pass to FinalGen
        final data = FinalGen.fromJson(jsonDecode(response.body));
        finalGen.value = data;

        if (data != null) {
          // set only the data.logs to finalGen.value.logs
          finalGen.value!.logs = data.logs;
          debugPrint('Logs Loaded ${data.logs}');
          if (finalGen.value!.status == 'succeeded') {
            isGenerated.value = true;
            debugPrint('Generated So no need to refresh');
          } else {
            debugPrint('Not Generated, So Refreshing in 4 seconds');
            Timer(Duration(seconds: 4), () {
              fetchCloset(get);
            });
          }
        } else {
          isGenerated.value = false;
        }
      } else {
        debugPrint('Failed to load data');
      }
    } catch (e) {
      // isLoading.value = false;
      // Get.snackbar('Error', e.toString());
    } finally {
      // isLoading.value = false;
    }
  }
}
