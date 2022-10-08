import 'dart:async';

import 'package:app/app/info/app_theme.dart';
import 'package:app/app/ui/page/login_page/login_binding.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/injection.dart';
import 'package:app/app/util/platform_util.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runZonedGuarded<void>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Injection.init();
      SmartDialog.config.loading = SmartConfigLoading(
        awaitOverType: SmartAwaitOverType.dialogAppear,
      );
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
      _hideKeyboard();
      runApp(const MyApp());
    },
    (Object e, StackTrace s) {
      LogUtil.e('Uncaught exceptions: $e', stackTrace: s);
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Soul Wallet',
      theme: appThemeData,
      getPages: Routes.routePage,
      initialBinding: LoginBinding(),
      initialRoute: Routes.loginPage,
      navigatorObservers: [FlutterSmartDialog.observer],
      scrollBehavior: const _ScrollBehavior(),
      builder: FlutterSmartDialog.init(
        builder: (_, Widget? child) => GestureDetector(
          onTap: _hideKeyboard,
          child: child,
        ),
      ),
    );
  }
}

class _ScrollBehavior extends MaterialScrollBehavior {
  const _ScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

void _hideKeyboard() {
  SystemChannels.textInput.invokeMethod('TextInput.hide').catchError((_) {});
}
