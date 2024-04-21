import 'package:closet_ai/app/utils/colors.dart';
import 'package:closet_ai/app/widgets/developer_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../../../main.dart';
import '../../../data/assets.dart';
import '../../../utils/custom_tap.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return RefreshIndicator(
      onRefresh: () async {
        // after 2 seconds, the refresh indicator will be dismissed
        await Future.delayed(const Duration(seconds: 2));
      },
      child: AnimationLimiter(
        child: Scaffold(
          backgroundColor: AppColors.scaffoldBg,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
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
                expandedHeight: 70.h,
                collapsedHeight: 70.h,
                floating: false,
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.h,
                        vertical: 1.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            MingCute.dress_fill,
                            color: Colors.white,
                          ),
                          5.horizontalSpace,
                          Text(
                            "Your Closet",
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    YourClosetWidget(),
                    // const UploadWidget(),
                    // const ForYouCard(),
                    200.verticalSpace,
                    const Footer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YourClosetWidget extends StatelessWidget {
  const YourClosetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int columnCount = 2;

    return Column(
      children: [
        CustomTap(
          onTap: () async {
            final userId = supabase.auth.currentUser!.id;
            final data =
                await supabase.from('generations').select().eq('id', userId);
            debugPrint('/////DATA: $data');
          },
          child: Text(
            "Fetch Data",
            style: GoogleFonts.ibmPlexSans(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          height: 0.6.sh,
          child: GridView.count(
            crossAxisCount: columnCount,
            children: List.generate(
              10,
              (int index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: columnCount,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: Container(
                        margin: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
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
      height: 190.h,
      margin: EdgeInsets.only(bottom: 70.h),
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
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTap(
                  onTap: () {
                    context.pushTransparentRoute(
                      DeveloperView(),
                    );
                    HapticFeedback.selectionClick();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      "Made with ❤️ by Samuel",
                      style: GoogleFonts.ibmPlexSans(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
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
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 20.h,
              ),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                  smoothness: 0.7,
                ),
                color: const Color(0xff101010),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.svgLogo,
                      width: 42.w,
                    ),
                    20.horizontalSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: 'Dress-up with ',
                            style: GoogleFonts.outfit(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffE0E0E0)),
                            /*defining default style is optional */
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Style',
                                style: GoogleFonts.outfit(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff7AE1FF)),
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
                      ],
                    ),
                  ])),
        ),
      ],
    );
  }
}
