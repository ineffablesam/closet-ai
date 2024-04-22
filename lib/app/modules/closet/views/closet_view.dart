import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:closet_ai/app/modules/closet/controllers/closet_controller.dart';
import 'package:closet_ai/app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../models/gen_model.dart';

class ClosetView extends GetView<ClosetController> {
  final Gen? gen;
  const ClosetView({super.key, this.gen});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClosetController());
    controller.fetchCloset(gen?.getUrl ?? '');
    debugPrint(gen?.getUrl ?? '');
    Timer.periodic(Duration(seconds: 4), (timer) {
      if (!controller.isGenerated.value) {
        controller.fetchCloset(gen?.getUrl ?? '');
      } else {
        timer.cancel();
      }
    });
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70.h,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              gen?.prompt ?? 'Closet',
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.scaffoldBg,
            expandedHeight: 80.h,
            collapsedHeight: 80.h,
            floating: false,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Obx(() => controller.isLoading.value
                ? Container(
                    height: 0.9.sh,
                    width: 1.sw,
                    alignment: Alignment.center,
                    child: CupertinoActivityIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (!controller.isGenerated.value)
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              child: Container(
                                padding: EdgeInsets.all(6.h),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900.withOpacity(0.5),
                                  border: Border.all(
                                    color:
                                        Colors.grey.shade400.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Shimmer(
                                    color: Colors.pink.withOpacity(0.5),
                                    child: SizedBox(
                                      height: 200.h,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: gen?.uploadedImage ?? "",
                                            height: 290.h,
                                            width: 0.9.sw,
                                            fit: BoxFit.cover,
                                          ),
                                          ClipRRect(
                                            // Clip it cleanly.
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 10, sigmaY: 10),
                                              child: Container(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Generating...',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              child: Container(
                                padding: EdgeInsets.all(6.h),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900.withOpacity(0.5),
                                  border: Border.all(
                                    color:
                                        Colors.grey.shade400.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        controller.finalGen.value.output!.last,
                                    height: 290.h,
                                    width: 0.9.sw,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 5.h),
                        child: Text(
                          'Prompt',
                          style: GoogleFonts.outfit(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 5.h),
                        child: Container(
                          padding: EdgeInsets.all(6.h),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900.withOpacity(0.5),
                            border: Border.all(
                              color: Colors.grey.shade400.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            gen!.prompt.toString(),
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 5.h),
                        child: Text(
                          'Status',
                          style: GoogleFonts.outfit(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      (controller.isGenerated.value)
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 5.h),
                              child: Container(
                                padding: EdgeInsets.all(6.h),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade800.withOpacity(0.2),
                                  border: Border.all(
                                    color:
                                        Colors.grey.shade400.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  controller.finalGen.value.status.toString(),
                                  style: GoogleFonts.outfit(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.green.shade400,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 5.h),
                              child: Container(
                                padding: EdgeInsets.all(6.h),
                                decoration: BoxDecoration(
                                  color:
                                      Colors.orange.shade800.withOpacity(0.2),
                                  border: Border.all(
                                    color:
                                        Colors.grey.shade400.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  "Queued",
                                  style: GoogleFonts.outfit(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.orange.shade400,
                                  ),
                                ),
                              ),
                            ),
                      (controller.isGenerated.value)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 5.h),
                                  child: Text(
                                    'Logs',
                                    style: GoogleFonts.outfit(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 5.h),
                                  child: Container(
                                    padding: EdgeInsets.all(6.h),
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.grey.shade800.withOpacity(0.2),
                                      border: Border.all(
                                        color: Colors.grey.shade400
                                            .withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      controller.finalGen.value.logs.toString(),
                                      style: GoogleFonts.outfit(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  )),
          ),
        ],
      ),
    );
  }
}
