import 'package:app/app/info/app_theme.dart';
import 'package:app/app/ui/page/login_page/login_binding.dart';
import 'package:app/app/ui/page/login_page/login_page.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      getPages: Routes.routePage,
      initialBinding: LoginBinding(),
      home: const LoginPage(),
    ),
  );
}
