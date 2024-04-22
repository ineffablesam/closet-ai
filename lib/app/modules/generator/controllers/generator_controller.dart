import 'dart:convert';

import 'package:closet_ai/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../models/init_gen_model.dart';

class GeneratorController extends GetxController {
  final promptController = TextEditingController();
  RxBool isImageUploading = false.obs;
  RxString uploadedImageUrl = ''.obs;

  // Form Params Start
  RxString selectedClothingType = RxString('');
  RxBool isGenerating = false.obs;
  // Form Params End

  List<String> topwearPrompts = [
    "Design a top with a plunging neckline.",
    "Craft a shirt with rolled-up sleeves.",
    "Create a blouse with a tie-front detail.",
    "Design a sweater with cable knit patterns.",
    "Craft a hoodie with a kangaroo pocket.",
    "Create a tank top with racerback straps.",
    "Design a t-shirt with a scoop neck.",
  ];

  List<String> bottomwearPrompts = [
    "Craft jeans with a relaxed fit.",
    "Design trousers with a tapered leg.",
    "Create a skirt with a high-waist silhouette.",
    "Craft shorts with a distressed finish.",
    "Design leggings with a high-rise waistband.",
    "Create joggers with a drawstring waist.",
    "Design culottes with wide-leg pants.",
  ];

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> doMagic() async {
    isGenerating.value = true;
    // first validate the form fields image url, clothing type, and prompt are not empty
    if (uploadedImageUrl.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please upload an image',
        backgroundColor: Colors.amber,
        colorText: Colors.grey.shade900,
      );
      return;
    }
    if (selectedClothingType.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a clothing type',
        backgroundColor: Colors.amber,
        colorText: Colors.grey.shade900,
      );
      return;
    }
    if (promptController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a prompt',
        backgroundColor: Colors.amber,
        colorText: Colors.grey.shade900,
      );
      return;
    }
    // if all fields are valid, then make json object to send to the API
    await generateClothing(
      uploadedImageUrl.value,
      promptController.text,
      selectedClothingType.value.toLowerCase(),
    );
  }

  Future<void> generateClothing(
      String imageUrl, String prompt, String clothingType) async {
    try {
      const REPLICATE_API_TOKEN = 'r8_HlIvcUm2WT7tZ8u7OuJUxr8vlkXcpnt07sDFx';
      final response = await http.post(
        Uri.parse('https://api.replicate.com/v1/predictions'),
        headers: {
          'Authorization': 'Bearer $REPLICATE_API_TOKEN',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "version":
              "4e7916cc6ca0fe2e0e414c32033a378ff5d8879f209b1df30e824d6779403826",
          "input": {
            "image":
                "https://replicate.delivery/pbxt/It7YNyAmywNkJXdMzXXsCuc7a6WLYl10nZJ4d2SiZ5NGdsE0/77816-2000x2667-mobile-hd-elon-musk-wallpaper-image.jpg",
            "prompt": "a person wearing blue jeans",
            "clothing": "bottomwear"
          }
        }),
      );

      if (response.statusCode == 201) {
        // parse the response to model InitGen
        final responseJson = jsonDecode(response.body);
        InitGen initGen = InitGen.fromJson(responseJson);
        debugPrint('Prompt from server: ${initGen.input?.prompt}');
        await supabase.from('generations').insert({
          'prompt': initGen.input?.prompt,
          'uploaded_image': imageUrl,
          'clothing_type': clothingType,
          'output': responseJson,
          'self_id': initGen.id,
          'get_url': initGen.urls?.get,
          'cancel_url': initGen.urls?.cancel,
          'status': initGen.status,
          'logs': initGen.logs,
          'user_id': supabase.auth.currentUser!.id,
        });
      } else {
        // Handle error response here
        print('Error: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      // Handle exception here
      print('Exception: $e');
    } finally {
      isGenerating.value = false;
    }
  }

  Future<void> initProcess() async {
    isImageUploading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageExtension = image.path.split('.').last.toLowerCase();
      final imageBytes = await image.readAsBytes();
      final userId = supabase.auth.currentUser!.id;
      final imagePath =
          '/$userId/closet_${DateTime.now().millisecondsSinceEpoch.toString()}';
      await supabase.storage.from('closet-generations').uploadBinary(
            imagePath,
            imageBytes,
            fileOptions: FileOptions(
              upsert: true,
              contentType: 'image/$imageExtension',
            ),
          );
      String imageUrl =
          supabase.storage.from('closet-generations').getPublicUrl(imagePath);
      imageUrl = Uri.parse(imageUrl).replace(queryParameters: {
        't': DateTime.now().millisecondsSinceEpoch.toString()
      }).toString();
      uploadedImageUrl.value = imageUrl;
    } catch (error) {
      debugPrint('Error during image upload: $error');
    } finally {
      isImageUploading.value = false;
    }
  }

  void selectClothingType(String clothingType) {
    selectedClothingType.value = clothingType;
  }

  // reset the uploaded image url
  void reset() async {
    await Future.delayed(const Duration(seconds: 1));
    uploadedImageUrl.value = '';
    selectedClothingType.value = '';
  }
}
