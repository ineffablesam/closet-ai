import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///TODO: Add your Supabase URL and Anon Key
  await Supabase.initialize(
    url: "https://htizemrliwzedutjgnrq.supabase.co",
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh0aXplbXJsaXd6ZWR1dGpnbnJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM2NDQyMzEsImV4cCI6MjAyOTIyMDIzMX0.-o1WqDNi7Ivz6zo24u8QrsRN5BRcQ42PFHC5GPlCe74',
  );

  runApp(ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    // Use builder only if you need to use library outside ScreenUtilInit context
    builder: (_, child) {
      return GetMaterialApp(
        title: "ClosetAi",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    },
  ));
}

final supabase = Supabase.instance.client;
