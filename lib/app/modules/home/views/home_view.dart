import 'package:closet_ai/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/assets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 60.h,
        width: 60.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            stops: const [0.1, 0.3, 1],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xff4900A6),
              Color(0xffA61DBD).withOpacity(0.5),
              Color(0xffFFB89A),
            ],
          ),
        ),
        child: IconButton(
          onPressed: () {
            // Get.toNamed('/add');
            debugPrint('Add button pressed');
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
            child: Center(
              child: Text(
                'Welcome to HomeView',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
