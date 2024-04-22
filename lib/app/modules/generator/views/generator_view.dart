// ignore_for_file: prefer_const_constructors

import 'dart:math' as math;
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:closet_ai/app/data/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../utils/custom_tap.dart';
import '../controllers/generator_controller.dart';

class GeneratorView extends GetView<GeneratorController> {
  const GeneratorView({super.key});
  @override
  Widget build(BuildContext context) {
    // init splash controller
    final GeneratorController controller = Get.put(GeneratorController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomTap(
                  onTap: () {
                    controller.reset();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 45.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.outfit(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              10.horizontalSpace,
              Obx(
                () => Expanded(
                  child: CustomTap(
                    onTap: () async {
                      await controller.doMagic();
                    },
                    child: Container(
                        height: 45.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: LinearGradient(
                            stops: const [0.1, 0.3, 1],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              Color(0xff4900A6),
                              Color(0xffA61DBD),
                              Color(0xffFFB89A),
                            ],
                          ),
                        ),
                        child: controller.isGenerating.value == true
                            ? Center(
                                child: CupertinoActivityIndicator(
                                color: Colors.white,
                              ))
                            : Text(
                                'Start Magic 🪄',
                                style: GoogleFonts.outfit(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              )),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Colors.transparent,
        body: FadeIn(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40.7, sigmaY: 40.7),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    // physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                      ),
                      child: Column(
                        children: [
                          60.verticalSpace,
                          Obx(
                            () => Column(
                              children: [
                                !controller.uploadedImageUrl.value.isEmpty
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Choose your desired outfit',
                                            style: GoogleFonts.outfit(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Add Image',
                                            style: GoogleFonts.outfit(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                20.verticalSpace,
                                !controller.uploadedImageUrl.value.isEmpty
                                    ? Container()
                                    : Container(
                                        height: 120.h,
                                        width: 1.sw,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          gradient: LinearGradient(
                                            stops: const [0.1, 0.5, 1],
                                            end: Alignment.bottomRight,
                                            begin: Alignment.topLeft,
                                            colors: [
                                              Color(0xff4900A6),
                                              Color(0xffA61DBD),
                                              Color(0xffFFB89A),
                                            ],
                                          ),
                                        ),
                                        child: Obx(
                                          () =>
                                              controller.isImageUploading
                                                          .value ==
                                                      true
                                                  ? Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.white),
                                                      ),
                                                    )
                                                  : Row(
                                                      children: [
                                                        10.horizontalSpace,
                                                        Expanded(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              // horizontal: 13.h,
                                                              vertical: 13.h,
                                                            ),
                                                            child: CustomTap(
                                                              onTap: () async {
                                                                HapticFeedback
                                                                    .selectionClick();
                                                                await controller
                                                                    .initProcess();
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.r),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      LucideIcons
                                                                          .upload,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    Text(
                                                                      "Upload",
                                                                      style: GoogleFonts
                                                                          .ibmPlexSans(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        10.horizontalSpace,
                                                        Expanded(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              // horizontal: 13.h,
                                                              vertical: 13.h,
                                                            ),
                                                            child: CustomTap(
                                                              onTap: () {
                                                                HapticFeedback
                                                                    .selectionClick();
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.r),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      LucideIcons
                                                                          .camera,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    Text(
                                                                      "Camera",
                                                                      style: GoogleFonts
                                                                          .ibmPlexSans(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        10.horizontalSpace,
                                                      ],
                                                    ),
                                        ),
                                      ),
                                controller.uploadedImageUrl.value.isEmpty
                                    ? Container()
                                    : Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5.h),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade900,
                                              border: Border.all(
                                                color: Colors.grey.shade800,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(13.r),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(13.r),
                                              child: CachedNetworkImage(
                                                imageUrl: controller
                                                    .uploadedImageUrl.value,
                                                height: 300.h,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        Shimmer(
                                                  child: Container(
                                                    color: Colors.grey.shade900,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                    ),
                                                    10.verticalSpace,
                                                    Text(
                                                      'Error loading image, Please try again',
                                                      style: GoogleFonts
                                                          .ibmPlexMono(
                                                        color: Colors.red,
                                                        fontSize: 8.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          20.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Clothing Type',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          10.verticalSpace,
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () => controller
                                                    .selectClothingType(
                                                        'Topwear'),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 6.w,
                                                    vertical: 5.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.r),
                                                    border: Border.all(
                                                      color: controller
                                                                  .selectedClothingType
                                                                  .value ==
                                                              'Topwear'
                                                          ? Color(0xff4900A6)
                                                          : Colors
                                                              .grey.shade800,
                                                    ),
                                                    color: controller
                                                                .selectedClothingType
                                                                .value ==
                                                            'Topwear'
                                                        ? Color(0xff4900A6)
                                                        : Colors.grey.shade900,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Topwear',
                                                      style: GoogleFonts.outfit(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              5.horizontalSpace,
                                              InkWell(
                                                onTap: () => controller
                                                    .selectClothingType(
                                                        'Bottomwear'),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 6.w,
                                                    vertical: 5.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: controller
                                                                  .selectedClothingType
                                                                  .value ==
                                                              'Bottomwear'
                                                          ? Color(0xff4900A6)
                                                          : Colors
                                                              .grey.shade800,
                                                    ),
                                                    color: controller
                                                                .selectedClothingType
                                                                .value ==
                                                            'Bottomwear'
                                                        ? Color(0xff4900A6)
                                                        : Colors.grey.shade900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.r),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Bottomwear',
                                                      style: GoogleFonts.outfit(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          20.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Prompt',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          10.verticalSpace,
                                          TextFormField(
                                            controller:
                                                controller.promptController,
                                            decoration: InputDecoration(
                                              hintText: 'Enter Prompt',
                                              hintStyle: GoogleFonts.outfit(
                                                color: Colors.grey.shade800,
                                                fontSize: 14.sp,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey.shade900,
                                            ),
                                            style: GoogleFonts.outfit(
                                              color: Colors.grey.shade200,
                                              fontSize: 14.sp,
                                            ),
                                            minLines: 6,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                          ),
                                          20.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Transform.rotate(
                                                angle: math.pi / 12.0,
                                                child: Lottie.asset(
                                                  AppAssets.promptIdea,
                                                  height: 50.h,
                                                  width: 50.w,
                                                ),
                                              ),
                                              Text(
                                                'Quick Prompts',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          10.verticalSpace,
                                          (controller.selectedClothingType
                                                      .isNotEmpty &&
                                                  controller
                                                          .selectedClothingType
                                                          .value ==
                                                      'Topwear')
                                              ? Wrap(
                                                  spacing: 10,
                                                  runSpacing: 10,
                                                  children: controller
                                                      .topwearPrompts
                                                      .map((prompt) {
                                                    return CustomTap(
                                                      onTap: () {
                                                        controller
                                                            .promptController
                                                            .text = prompt;
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 10.h,
                                                          vertical: 5.w,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade900,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        child: Text(
                                                          prompt,
                                                          style: GoogleFonts
                                                              .ibmPlexMono(
                                                            color: Colors
                                                                .grey.shade200,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                )
                                              : Wrap(
                                                  spacing: 10,
                                                  runSpacing: 10,
                                                  children: controller
                                                      .bottomwearPrompts
                                                      .map((prompt) {
                                                    return CustomTap(
                                                      onTap: () {
                                                        controller
                                                            .promptController
                                                            .text = prompt;
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 10.h,
                                                          vertical: 5.w,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade900,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        child: Text(
                                                          prompt,
                                                          style: GoogleFonts
                                                              .ibmPlexMono(
                                                            color: Colors
                                                                .grey.shade200,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                          200.verticalSpace,
                                        ],
                                      ),
                              ],
                            ),
                          ),
                          99.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    height: 0.2.sh,
                    decoration: BoxDecoration(
                      // color: Colors.black,
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: FractionalOffset.topCenter,
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.transparent,
                        ],
                        stops: const [0, 0.30],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
