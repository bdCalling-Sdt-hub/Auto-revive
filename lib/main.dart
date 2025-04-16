import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/config/app_routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
       return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Auto Revive',
          routeInformationParser: AppRoutes.goRouter.routeInformationParser,
          routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
         routerDelegate: AppRoutes.goRouter.routerDelegate,
        );
      }
    );
  }
}
