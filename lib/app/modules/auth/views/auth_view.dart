import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../data/assets.dart';
import '../../../utils/colors.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            SvgPicture.asset(
              AppAssets.authBg,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Reimagine yourself with AI',
                  style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                2.verticalSpace,
                Text(
                  'Login Now to Continue',
                  style: GoogleFonts.outfit(
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                10.verticalSpace,
                Obx(
                  () => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: InkWell(
                      onTap: () async {
                        await controller.googleSignIn();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white30,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 14.h,
                          ),
                          child: controller.isLoading.value
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CupertinoActivityIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Bootstrap.google,
                                      color: Colors.white,
                                    ),
                                    10.horizontalSpace,
                                    Text(
                                      'Sign in with Google',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SvgPicture.asset(
                AppAssets.svgLogoWithName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
