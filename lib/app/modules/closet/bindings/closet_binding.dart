import 'package:get/get.dart';

import '../controllers/closet_controller.dart';

class ClosetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClosetController>(
      () => ClosetController(),
    );
  }
}
