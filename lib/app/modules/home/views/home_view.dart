import 'package:cached_network_image/cached_network_image.dart';
import 'package:closet_ai/app/modules/closet/views/closet_view.dart';
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
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smooth_corner/smooth_corner.dart';

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
        await controller.fetchCloset();
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
                            size: 14.sp,
                          ),
                          5.horizontalSpace,
                          Text(
                            "Your Closet",
                            style: GoogleFonts.outfit(
                              color: Colors.grey.shade300,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: YourClosetWidget(),
                    ),
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
    final controller = Get.put(HomeController());

    return Column(
      children: [
        Container(
          // height: 0.6.sh,
          // controller.gen to generate the list of items
          child: Obx(() => controller.isFetchingCloset.value
              ? _buildClosetLoading()
              : (controller.gen.value.isEmpty)
                  ? Text("No Generations Found for you")
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 0.5.sw,
                        mainAxisSpacing: 0,
                        childAspectRatio: 1,
                        mainAxisExtent: 275.h,
                      ),
                      itemCount: controller.gen.value.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: controller.gen.value.length,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 5.h,
                                ),
                                child: CustomTap(
                                  onTap: () {
                                    Get.to(
                                      () => ClosetView(
                                        gen: controller.gen.value[index],
                                      ),
                                      transition: Transition.cupertino,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade900.withOpacity(
                                        0.4,
                                      ),
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5.h,
                                        horizontal: 7.w,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(14.r),
                                            child: CachedNetworkImage(
                                              imageUrl: controller
                                                  .gen
                                                  .value[index]
                                                  .uploadedImage as String,
                                              height: 160.h,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          10.verticalSpace,
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 140.w,
                                                  child: Text(
                                                    controller.gen.value[index]
                                                        .prompt as String,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.outfit(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          5.verticalSpace,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
        ),
      ],
    );
  }
}

class _buildClosetLoading extends StatelessWidget {
  const _buildClosetLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        // crossAxisCount: 2,
        maxCrossAxisExtent: 0.5.sw,
        mainAxisSpacing: 0,
        childAspectRatio: 1,
        mainAxisExtent: 275.h,
      ),
      itemCount: 7,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 375),
          columnCount: 7,
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 5.h,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900.withOpacity(
                      0.2,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.h,
                      horizontal: 7.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14.r),
                          child: Shimmer(
                            child: SizedBox(
                              height: 160.h,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7.r),
                              child: Shimmer(
                                child: SizedBox(
                                  height: 10.h,
                                  width: 60.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                        5.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7.r),
                                  child: Shimmer(
                                    child: SizedBox(
                                      height: 15.h,
                                      width: 120.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        5.verticalSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7.r),
                                  child: Shimmer(
                                    child: SizedBox(
                                      height: 15.h,
                                      width: 90.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            5.verticalSpace,
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7.r),
                                  child: Shimmer(
                                    child: SizedBox(
                                      height: 15.h,
                                      width: 70.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
