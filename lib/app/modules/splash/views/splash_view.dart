// ignore_for_file: prefer_const_constructors

import 'dart:math' as math;

import 'package:closet_ai/app/data/assets.dart';
import 'package:closet_ai/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    // init splash controller
    final SplashController controller = Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Shimmer(
        duration: Duration(seconds: 3),
        color: Colors.grey.shade50,
        colorOpacity: 0.1,
        enabled: true,
        direction: ShimmerDirection.fromLTRB(),
        child: Stack(
          children: [
            Container(
              height: 1.sh,
              width: 1.sw,
              child: Lottie.asset(
                reverse: true,
                alignment: Alignment.bottomCenter,
                AppAssets.sparkleLottie,
                fit: BoxFit.fitWidth,
              ),
            ),
            // flip animation
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Container(
                height: 1.sh,
                width: 1.sw,
                child: Lottie.asset(
                  alignment: Alignment.topCenter,
                  AppAssets.sparkleLottie,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Center(
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
                    ).animate().fadeIn(
                          duration: Duration(
                            seconds: 2,
                          ),
                        ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
