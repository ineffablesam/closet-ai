import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:closet_ai/app/modules/home/views/home_view.dart';
import 'package:closet_ai/app/modules/profile/controllers/profile_controller.dart';
import 'package:closet_ai/app/utils/colors.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../main.dart';
import '../../../widgets/developer_widget.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: FadeIn(
              child: Text(
                "Profile",
                style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
            ),
            centerTitle: true,
            toolbarHeight: 58.h,
            automaticallyImplyLeading: false,
            expandedHeight: 150.h,
            elevation: 0,
            pinned: true,
            stretch: true,
            backgroundColor: const Color(0xff4900A6),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              background: Container(
                padding: EdgeInsets.only(top: 30.h),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.1, 0.3, 1],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color(0xff4900A6),
                      Color(0xffA61DBD),
                      Color(0xffFFB89A),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: Colors.grey.shade900,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.0))),
                                title: Text(
                                  "Logout",
                                  style: GoogleFonts.outfit(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                content: Text(
                                  "Are you sure to logout?",
                                  style: GoogleFonts.outfit(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(14),
                                          child: const Text("Cancel",
                                              style: TextStyle()),
                                        ),
                                      ),
                                      Obx(
                                        () => controller.isLoading.value
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : TextButton(
                                                onPressed: () async {
                                                  await controller.signOut();
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  child: const Text("Sign out",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      )),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 18.5.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 45.r,
                              backgroundColor:
                                  Colors.grey.shade600.withOpacity(0.3),
                              child: Padding(
                                padding: EdgeInsets.all(7.h),
                                child: CachedNetworkImage(
                                  imageUrl: supabase.auth.currentUser!
                                      .userMetadata!['avatar_url'] as String,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 90.w,
                                    height: 90.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => ClipRRect(
                                    borderRadius: BorderRadius.circular(50.r),
                                    child: Shimmer(
                                        color: Colors.pink.shade900
                                            .withOpacity(0.5),
                                        child: CircleAvatar(
                                          radius: 50.r,
                                          backgroundColor: Colors.grey.shade900
                                              .withOpacity(0.5),
                                        )),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    backgroundColor:
                                        Colors.grey.shade900.withOpacity(0.5),
                                    radius: 50.r,
                                    child: const Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  supabase.auth.currentUser!
                                      .userMetadata!['full_name'] as String,
                                  style: GoogleFonts.outfit(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.w, vertical: 5.h),
                                  child: Container(
                                    padding: EdgeInsets.all(6.h),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade800
                                          .withOpacity(0.2),
                                      border: Border.all(
                                        color: Colors.grey.shade400
                                            .withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      "Active",
                                      style: GoogleFonts.outfit(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.green.shade400,
                                      ),
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
                10.verticalSpace,
                _BuildCustomSpecialGradientButton(
                  color1: const Color(0xFF6A46A9),
                  color2: const Color(0xFF311267),
                  icon: "",
                  title: 'Developer',
                  onTap: () {
                    context.pushTransparentRoute(
                      DeveloperView(),
                    );
                    HapticFeedback.selectionClick();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 15.h, right: 15.h, bottom: 15.h, top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Account",
                            style: GoogleFonts.outfit(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomMenuOuterCard(
                  child: Column(
                    children: [
                      CustomListStyle(
                        Logovisible: true,
                        visible: true,
                        onTap: () {},
                        icon: Icons.supervisor_account_rounded,
                        title: 'Community',
                        subtitle: 'Join the community',
                        gradientColor: const [
                          Color(0xffFFCF01),
                          Color(0xffD1A300)
                        ],
                      ),
                      CustomListStyle(
                        Logovisible: true,
                        visible: true,
                        onTap: () {},
                        icon: Icons.settings,
                        title: 'Privacy',
                        subtitle: 'Control your privacy settings',
                        gradientColor: const [
                          Color(0xff4B7BFD),
                          Color(0xff1744BF)
                        ],
                      ),
                      CustomListStyle(
                        Logovisible: true,
                        visible: true,
                        onTap: () {},
                        icon: Icons.info,
                        title: 'What\'s New',
                        subtitle: 'Check out What\'s New in this Update',
                        gradientColor: const [
                          Color(0xff450dee),
                          Color(0xff2417e3)
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 15.h, right: 15.h, bottom: 15.h, top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Application",
                            style: GoogleFonts.outfit(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomMenuOuterCard(
                  child: Column(
                    children: [
                      CustomListStyle(
                        Logovisible: true,
                        visible: true,
                        onTap: () {},
                        icon: Icons.bug_report,
                        title: 'Report a Bug',
                        subtitle: 'Report a bug in the application',
                        gradientColor: const [
                          Color(0xfffc153f),
                          Color(0xffc8002e)
                        ],
                      ),
                      CustomListStyle(
                        Logovisible: true,
                        visible: true,
                        onTap: () {},
                        icon: Icons.settings,
                        title: 'Feature Request',
                        subtitle: 'Request a feature in the application',
                        gradientColor: const [
                          Color(0xff4bfda4),
                          Color(0xff029a4f),
                        ],
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildCustomSpecialGradientButton extends StatelessWidget {
  final String title, icon;
  final Color color1, color2;
  final VoidCallback? onTap;
  const _BuildCustomSpecialGradientButton({
    required this.title,
    required this.color1,
    required this.color2,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10.r);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 5.h,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Material(
          borderRadius: borderRadius,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  color1,
                  color2,
                ],
                stops: const [0, 1],
              ),
            ),
            child: InkWell(
              onTap: onTap,
              splashFactory: InkSparkle.splashFactory,
              borderRadius: borderRadius,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    height: 80.h,
                  ),
                  Positioned(
                    top: -45.h,
                    left: -40.w,
                    // child: SvgPicture.asset(
                    //   icon,
                    //   height: 190.h,
                    // ),
                    child: Icon(
                      TeenyIcons.code,
                      size: 170.sp,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListStyle extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColor;
  final GestureTapCallback? onTap;
  bool visible;
  bool Logovisible;
  CustomListStyle({
    Key? key,
    required this.Logovisible,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradientColor,
    required this.onTap,
    required this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodySmall!.color!;
    return Column(
      children: [
        Material(
          color: Colors.grey.shade900.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15.r),
          child: InkWell(
            onTap: onTap,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              onTap: null,
              leading: Visibility(
                visible: Logovisible,
                child: Container(
                  width: 39.h,
                  height: 39.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: gradientColor,
                      )),
                  child: Icon(
                    icon,
                    size: 19.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 11.4.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade50,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: GoogleFonts.outfit(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
              trailing: Visibility(
                visible: visible,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFADADAD),
                  size: 13.sp,
                  weight: 19,
                ),
              ),
              // tileColor: Colors.white,
              dense: false,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomMenuOuterCard extends StatelessWidget {
  final Widget child;
  const CustomMenuOuterCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 4),
              blurRadius: 47,
              spreadRadius: 20,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    offset: Offset(0, 4),
                    blurRadius: 47,
                    spreadRadius: 20,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: child,
              )),
        ),
      ),
    );
  }
}

class _buildProfileListTile extends StatelessWidget {
  const _buildProfileListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      height: 60.h,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade900.withOpacity(0.5),
                      Colors.blue.shade200.withOpacity(0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(13.h),
                  child: const Icon(
                    Icons.supervisor_account,
                    color: Colors.white,
                  ),
                ),
              ),
              10.horizontalSpace,
              Text(
                'Community',
                style: GoogleFonts.outfit(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
