import 'package:closet_ai/app/modules/auth/bindings/auth_binding.dart';
import 'package:closet_ai/app/modules/auth/views/auth_view.dart';
import 'package:closet_ai/app/modules/closet/bindings/closet_binding.dart';
import 'package:closet_ai/app/modules/closet/views/closet_view.dart';
import 'package:closet_ai/app/modules/core/layout/bindings/layout_binding.dart';
import 'package:closet_ai/app/modules/core/layout/views/layout_view.dart';
import 'package:closet_ai/app/modules/splash/bindings/splash_binding.dart';
import 'package:closet_ai/app/modules/splash/views/splash_view.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.LAYOUT,
      page: () => const LayoutView(),
      binding: LayoutBinding(),
    ),
    GetPage(
      name: _Paths.CLOSET,
      page: () => const ClosetView(),
      binding: ClosetBinding(),
    ),
  ];
}
