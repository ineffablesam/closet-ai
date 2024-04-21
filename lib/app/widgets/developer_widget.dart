import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:closet_ai/app/data/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

import '../utils/custom_tap.dart';

class DeveloperView extends StatefulWidget {
  const DeveloperView({
    super.key,
  });

  @override
  State<DeveloperView> createState() => _DeveloperViewState();
}

class _DeveloperViewState extends State<DeveloperView> {
  final List<String> skills = [
    'Flutter',
    'Supabase',
    'AI/ML',
    'NodeJS',
    'PHP',
    'Laravel',
    'NextJS',
    'Python',
    'Express',
    'SQL & NoSQL',
    'Git',
    'Linux',
    'Docker',
    'Kubernetes',
    'Firebase',
    'Google Cloud',
    'AWS',
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        floatingActionButton: CustomTap(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: CircleAvatar(
            radius: 24.r,
            backgroundColor: Colors.white,
            child: IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    child: Column(
                      children: [
                        99.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'About Me',
                              style: GoogleFonts.outfit(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Lottie.asset(
                              AppAssets.emoji1,
                              height: 30.h,
                              width: 30.h,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.h,
                                vertical: 20.h,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppAssets.developer,
                                        width: 80.h,
                                      ),
                                      10.horizontalSpace,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Samuel Philip',
                                            style: GoogleFonts.outfit(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                          5.verticalSpace,
                                          Text(
                                            'Student/Full-Stack Developer',
                                            style: GoogleFonts.outfit(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    "🔮 The Multiverse Coder 🌍 | Laravel 🚀, Node.js 🌟, Flutter 🦋 | Linux 🐧, Databases 📚 | JS 🚀 || I'm the person who wastes my time just to save yours! 🫣😬",
                                    style: GoogleFonts.outfit(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                  20.verticalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Skills',
                                        style: GoogleFonts.outfit(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      10.verticalSpace,
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: skills.map((skill) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.h,
                                              vertical: 5.w,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade900,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Text(
                                              skill,
                                              style: GoogleFonts.ibmPlexMono(
                                                color: Colors.grey.shade200,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  20.verticalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Get in touch with me! 📬',
                                        style: GoogleFonts.outfit(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      10.verticalSpace,
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 20.r,
                                              backgroundColor:
                                                  Colors.grey.shade900,
                                              child: const Icon(
                                                Icons.mail,
                                                color: Colors.white,
                                              ),
                                            ),
                                            5.horizontalSpace,
                                            CircleAvatar(
                                              radius: 20.r,
                                              backgroundColor:
                                                  Colors.grey.shade900,
                                              child: Icon(
                                                Bootstrap.whatsapp,
                                                color: Colors.white,
                                              ),
                                            ),
                                            5.horizontalSpace,
                                            CircleAvatar(
                                              radius: 20.r,
                                              backgroundColor:
                                                  Colors.grey.shade900,
                                              child: Icon(
                                                Bootstrap.instagram,
                                                color: Colors.white,
                                              ),
                                            ),
                                            5.horizontalSpace,
                                            CircleAvatar(
                                              radius: 20.r,
                                              backgroundColor:
                                                  Colors.grey.shade900,
                                              child: Icon(
                                                Bootstrap.linkedin,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ]),
                                      120.verticalSpace
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        99.verticalSpace,
                      ],
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
