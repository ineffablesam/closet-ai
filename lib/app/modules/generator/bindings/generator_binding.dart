import 'package:get/get.dart';

import '../controllers/generator_controller.dart';

class GeneratorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneratorController>(
      () => GeneratorController(),
    );
  }
}
