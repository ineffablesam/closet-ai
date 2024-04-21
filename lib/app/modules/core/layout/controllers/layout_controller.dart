import 'package:get/get.dart';

class LayoutController extends GetxController {
  final RxInt _pageIndex = 0.obs;
  final RxInt _previousPageIndex = 0.obs;
  // function for triggering the shop page action
  void Function()? action;

  void setAction(void Function() newAction) {
    action = newAction;
  }

  int get currentIndex => _pageIndex.value;
  int get previousPageIndex => _previousPageIndex.value;

  void updatePageIndex(int newIndex) {
    _previousPageIndex.value = _pageIndex.value;
    _pageIndex.value = newIndex;
    update();
  }

  // function go to index
  void goToIndex(int index) {
    _previousPageIndex.value = _pageIndex.value;
    _pageIndex.value = index;
    update();
  }
}
