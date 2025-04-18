import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/config/app_routes/app_routes.dart';
import 'core/config/app_themes/app_themes.dart';

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
         theme: Themes().lightTheme,
         darkTheme: Themes().lightTheme,
          routeInformationParser: AppRoutes.goRouter.routeInformationParser,
          routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
          routerDelegate: AppRoutes.goRouter.routerDelegate,
        );
      }
    );
  }
}
