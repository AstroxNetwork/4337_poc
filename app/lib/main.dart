import 'package:app/app/info/app_theme.dart';
import 'package:app/app/ui/page/login_page/login_binding.dart';
import 'package:app/app/ui/page/login_page/login_page.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/injection.dart';
import 'package:app/eip4337lib/utils/log_utils.dart';
import 'package:app/app/util/platform_util.dart';
import 'package:app/net/dio_utils.dart';
import 'package:app/net/intercept.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.init();
  runApp(
    MyApp(),
  );
  if (PlatformUtil.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  MyApp() {
    initDio();
  }

  void initDio() {
    final List<Interceptor> interceptors = <Interceptor>[];

    /// 统一添加身份验证请求头
    interceptors.add(AuthInterceptor());
    configDio(
      connectTimeout: 15000,
      baseUrl: 'https://securecenter-poc.soulwallets.me',
      interceptors: interceptors,
    );
    Log.init();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      getPages: Routes.routePage,
      initialBinding: LoginBinding(),
      home: const LoginPage(),
    );
  }
}
