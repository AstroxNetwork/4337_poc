import 'package:app/app/ui/page/creaete_page/email_page/email_binding.dart';
import 'package:app/app/ui/page/creaete_page/email_page/email_page.dart';
import 'package:app/app/ui/page/creaete_page/password_page/password_binding.dart';
import 'package:app/app/ui/page/creaete_page/password_page/password_page.dart';
import 'package:app/app/ui/page/home_page/home_binding.dart';
import 'package:app/app/ui/page/home_page/home_page.dart';
import 'package:app/app/ui/page/login_page/login_binding.dart';
import 'package:app/app/ui/page/login_page/login_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class Routes {
  static const String loginPage = '/login';
  static const String emailPage = '/email';
  static const String passwordPage = '/password';
  static const String homePage = '/home';

  static final routePage = [
    GetPage(
        name: loginPage,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: emailPage,
        page: () => const EmailPage(),
        binding: EmailBinding()),
    GetPage(
        name: passwordPage,
        page: () => const PasswordPage(),
        binding: PasswordBinding()),
    GetPage(
      name: homePage,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}