import 'package:closet_ai/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../../data/assets.dart';
import '../../../utils/custom_tap.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70.h,
            title: SvgPicture.asset(
              AppAssets.svgLogoWithName,
              height: 26.h,
            ),
            backgroundColor: AppColors.scaffoldBg,
            actions: [
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : IconButton(
                        onPressed: () async {
                          await controller.signOut();
                        },
                        icon: const Icon(Icons.logout),
                      ),
              ),
            ],
            expandedHeight: 80.h,
            collapsedHeight: 80.h,
            floating: false,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ForYouCard(),
                200.verticalSpace,
                Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      margin: EdgeInsets.only(bottom: 50.h),
      decoration: BoxDecoration(
        color: const Color(0xff101010),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 20.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Super Charged with 🔥",
                  style: GoogleFonts.ibmPlexSans(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTap(
                  child: Image.asset(
                    AppAssets.supabaseLogo,
                    width: 100.h,
                  ),
                ),
                CustomTap(
                  child: Image.asset(
                    AppAssets.flutterLogo,
                    width: 100.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ForYouCard extends StatelessWidget {
  const ForYouCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 20.h, left: 20.h, top: 02.h),
          child: Container(
              width: 297.h,
              height: 317.h,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                  smoothness: 0.7,
                ),
                color: const Color(0xff101010),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.svgLogo,
                      width: 40.w,
                    ),
                    SizedBox(height: 20.h),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Dress-up with\n',
                        style: GoogleFonts.outfit(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffE0E0E0)),
                        /*defining default style is optional */
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Style',
                            style: GoogleFonts.outfit(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff7AE1FF)),
                          ),
                          TextSpan(
                            text: ' using Ai',
                            style: GoogleFonts.outfit(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffE0E0E0)),
                          ),
                        ],
                      ),
                    ),
                    2.verticalSpace,
                    Text(
                      'Customize as you like',
                      style: GoogleFonts.outfit(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffFFFFFF).withOpacity(0.5)),
                    ),
                    SizedBox(height: 20.h),
                    CustomTap(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   PageRouteBuilder(
                        //     pageBuilder: (_, __, ___) => Layout(index: 2),
                        //     transitionDuration: const Duration(seconds: 5),
                        //   ),
                        // );
                      },
                      child: Container(
                        height: 45.h,
                        width: 144.h,
                        decoration: BoxDecoration(
                          boxShadow: [
                            const BoxShadow(
                              offset: Offset(3, 3),
                              spreadRadius: -1,
                              blurRadius: 50,
                              color: Color.fromRGBO(239, 239, 239, 0.55),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Center(
                          child: Text(
                            "Try Now 🪄",
                            style: GoogleFonts.outfit(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff060606)),
                          ),
                        ),
                      ),
                    )
                  ])),
        ),
      ],
    );
  }
}
