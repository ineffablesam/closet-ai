// ignore_for_file: prefer_const_constructors

import 'package:closet_ai/app/data/assets.dart';
import 'package:closet_ai/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    // init splash controller
    final SplashController controller = Get.put(SplashController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      backgroundColor: AppColors.scaffoldBg,
      body: Center(
        child: SvgPicture.asset(
          AppAssets.svgLogo,
          height: 120.h,
          semanticsLabel: 'A red up arrow',
        )
            .animate(
              delay: Duration(seconds: 2),
            )
            .fadeOut(
              duration: Duration(milliseconds: 200),
            )
            .swap(
              builder: (_, __) => SvgPicture.asset(
                AppAssets.svgName,
                width: 180.w,
                semanticsLabel: 'A red up arrow',
              ).animate().fadeIn(
                    duration: Duration(
                      seconds: 2,
                    ),
                  ),
            ),
      ),
    );
  }
}
