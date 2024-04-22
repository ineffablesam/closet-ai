import 'package:closet_ai/app/modules/closet/controllers/closet_controller.dart';
import 'package:closet_ai/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/gen_model.dart';

class ClosetView extends GetView<ClosetController> {
  final Gen? gen;
  const ClosetView({super.key, this.gen});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70.h,
            title: Text(
              'Closet',
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
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
            child: Center(
              child: Text(
                'Welcome to ProfileView',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
