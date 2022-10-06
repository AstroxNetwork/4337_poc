import 'package:app/app/info/app_theme.dart';
import 'package:app/app/ui/page/login_page/login_binding.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/injection.dart';
import 'package:app/eip4337lib/utils/log_utils.dart';
import 'package:app/app/util/platform_util.dart';
import 'package:app/net/dio_utils.dart';
import 'package:app/net/intercept.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.init();
  if (PlatformUtil.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
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
      initialRoute: Routes.loginPage,
      builder: FlutterSmartDialog.init(
        builder: (_, Widget? child) => GestureDetector(
          onTap: () => SystemChannels.textInput
              .invokeMethod('TextInput.hide')
              .catchError((_) {}),
          child: child,
        ),
      ),
    );
  }
}
