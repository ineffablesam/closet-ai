import 'package:closet_ai/app/modules/auth/bindings/auth_binding.dart';
import 'package:closet_ai/app/modules/auth/views/auth_view.dart';
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
  ];
}
