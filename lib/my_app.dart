import 'dart:io';
import 'package:provider/single_child_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'app/core/resources/colors/app_colors.dart';
import 'app/core/resources/strings/app_strings.dart';
import 'app/core/routes/library/routes_library.dart';
import 'app/pages/splash/providers/splash_provider.dart';
import 'main.dart';
import 'app/core/utils/flavor_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouteObserver = AppRouteObserver();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      child: MultiProvider(
        providers: providerList,
        child: MaterialApp(
          title: AppString.appName,
          debugShowCheckedModeBanner: FlavorConfig.isDEV() ? true : false,
          navigatorKey: navigatorKey,
          navigatorObservers: <NavigatorObserver>[
            routeObserver,
            appRouteObserver,
          ],
          theme: ThemeData(
            primarySwatch: Colors.blue,
            bottomSheetTheme: BottomSheetThemeData(
              dragHandleColor: AppColors.black, // Change to desired color
            ),
          ),
          initialRoute: AppPages.initial,
          onGenerateRoute: AppPages.routes,
          builder:
              (context, child) => SafeArea(
                top: false,
                bottom: Platform.isIOS ? false : true,
                child: MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.noScaling),
                  child: child!,
                ),
              ),
        ),
      ),
    );
  }
}

List<SingleChildWidget> providerList = [
  ChangeNotifierProvider<SplashProvider>(create: (_) => SplashProvider()),
];
