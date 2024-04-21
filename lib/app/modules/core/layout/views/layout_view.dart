import 'package:closet_ai/app/modules/core/layout/controllers/layout_controller.dart';
import 'package:closet_ai/app/modules/home/views/home_view.dart';
import 'package:closet_ai/app/modules/profile/views/profile_view.dart';
import 'package:closet_ai/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../data/assets.dart';

class LayoutView extends GetView<LayoutController> {
  const LayoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final activeColor = AppColors.primary;
    final activeColor = Color(0xffdbc5fd);
    final inactiveColor = Color(0x80ffffff);
    List<Widget> pages = [
      HomeView(),
      const ProfileView(),
    ];
    final bottomNavBarController = Get.put(LayoutController());
    return Obx(() => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
            body: PageTransitionSwitcher(
                duration: const Duration(milliseconds: 400),
                reverse: bottomNavBarController.currentIndex <
                    bottomNavBarController.previousPageIndex,
                transitionBuilder: (child, animation, secondaryAnimation) =>
                    SharedAxisTransition(
                      fillColor: Color(0xFF000000),
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                      child: child,
                    ),
                child: pages.elementAt(bottomNavBarController.currentIndex)),
            bottomNavigationBar: Stack(
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
                      child: SizedBox(
                        width: double.infinity,
                        height: 69.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 69.h,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: BottomAppBar(
                      shape: const CircularNotchedRectangle(),
                      notchMargin: 8,
                      elevation: 0,
                      color: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      clipBehavior: Clip.hardEdge,
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        backgroundColor:
                            const Color(0xB3000000).withOpacity(0.5),
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        selectedLabelStyle: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w400,
                          color: activeColor,
                          height: 1.5.h,
                        ),
                        unselectedLabelStyle: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        selectedItemColor: activeColor,
                        unselectedItemColor: Colors.grey,
                        selectedFontSize: 8.sp,
                        unselectedFontSize: 8.sp,
                        enableFeedback: true,
                        items: [
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              AppAssets.homeInactiveSvg,
                              color: inactiveColor,
                            ),
                            activeIcon: SvgPicture.asset(
                              AppAssets.homeSvg,
                              color: activeColor,
                            ),
                            label: 'Home',
                            tooltip: '',
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              AppAssets.eventInactiveSvg,
                              color: inactiveColor,
                            ),
                            activeIcon: SvgPicture.asset(
                              AppAssets.eventSvg,
                              color: activeColor,
                            ),
                            label: 'Events',
                            tooltip: '',
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              AppAssets.mentionInactiveSvg,
                              color: inactiveColor,
                            ),
                            activeIcon: SvgPicture.asset(
                              AppAssets.mentionSvg,
                              color: activeColor,
                            ),
                            label: 'Mentions',
                            tooltip: '',
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              AppAssets.profileInactiveSvg,
                              color: inactiveColor,
                            ),
                            activeIcon: SvgPicture.asset(
                              AppAssets.profileSvg,
                              color: activeColor,
                            ),
                            label: 'Account',
                            tooltip: '',
                          ),
                        ],
                        currentIndex: bottomNavBarController.currentIndex,
                        onTap: (index) {
                          HapticFeedback.lightImpact();
                          bottomNavBarController.updatePageIndex(index);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return CircularNotchedRectangle().getOuterPath(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Rect.fromCircle(center: Offset(size.width / 2, 2), radius: 39),
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
