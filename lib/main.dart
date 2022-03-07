import 'dart:io';

import 'package:alert/alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:self_check_3/presentation/main/main_controller.dart';
import 'package:self_check_3/resource/theme/app_color.dart';
import 'package:self_check_3/resource/values/colors.dart';
import 'package:self_check_3/route/pages.dart';
import 'package:self_check_3/route/routes.dart';
import 'package:self_check_3/util/check_util.dart';

const supportedLocales = [Locale('ko', 'KR')];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness:
          Platform.isIOS ? Brightness.dark : Brightness.light));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(EasyLocalization(
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      fallbackLocale: Locale('ko', 'KR'),
      child: MyApp()));

  if (!(await CheckUtil.isInternetConnected())) {
    Alert(message: "인터넷 연결을 확인 한 후, 다시 앱을 실행해주세요.", shortDuration: false)
        .show();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'self_check_v3',
        initialRoute: Routes.webview,
        getPages: ApplicationPages.pages,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'spoqa',
            scaffoldBackgroundColor: AppColor.lightBackground,
            appBarTheme: AppBarTheme(
                color: AppColor.lightBackground,
                elevation: 1,
                shadowColor: ColorPalette.gray02,
                iconTheme: IconThemeData(color: AppColor.onSecondary)),
            backgroundColor: AppColor.darkBackground,
            textTheme: TextTheme(
              headline6: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              bodyText2: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            )),
      );
}
