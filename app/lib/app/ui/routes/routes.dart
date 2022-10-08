import 'package:get/get_navigation/src/routes/get_route.dart';

import '../page/creaete_page/password_page/password_binding.dart';
import '../page/creaete_page/password_page/password_page.dart';
import '../page/debug_page/debug_binding.dart';
import '../page/debug_page/debug_page.dart';
import '../page/guardian_page/guardian_binding.dart';
import '../page/guardian_page/guardian_page.dart';
import '../page/help_page/help_binding.dart';
import '../page/help_page/help_page.dart';
import '../page/home_page/home_binding.dart';
import '../page/home_page/home_page.dart';
import '../page/login_page/login_binding.dart';
import '../page/login_page/login_page.dart';
import '../page/recover_page/recover_page/recover_binding.dart';
import '../page/recover_page/recover_page/recover_page.dart';
import '../page/recover_page/signed_page/signed_binding.dart';
import '../page/recover_page/signed_page/signed_page.dart';
import '../page/recover_page/transaction_page/transaction_binding.dart';
import '../page/recover_page/transaction_page/transaction_page.dart';
import '../page/scan_page/scan_binding.dart';
import '../page/scan_page/scan_page.dart';

class Routes {
  const Routes._();

  static const String debugPage = '/debug';
  static const String loginPage = '/login';
  static const String passwordPage = '/password';
  static const String homePage = '/home';
  static const String guardianPage = '/guardian';
  static const String recoverPage = '/recover';
  static const String transactionPage = '/transaction';
  static const String signedPage = '/signed';
  static const String scanPage = '/scan';
  static const String helpPage = '/help';

  static final routePage = [
    GetPage(
      name: debugPage,
      page: () => DebugPage(),
      binding: DebugBinding(),
    ),
    GetPage(
      name: loginPage,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: passwordPage,
      page: () => const PasswordPage(),
      binding: PasswordBinding(),
    ),
    GetPage(
      name: homePage,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: guardianPage,
      page: () => GuardianPage(),
      binding: GuardianBinding(),
    ),
    GetPage(
      name: recoverPage,
      page: () => const RecoverPage(),
      binding: RecoverBinding(),
    ),
    GetPage(
      name: transactionPage,
      page: () => const TransactionPage(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: signedPage,
      page: () => SignedPage(),
      binding: SignedBinding(),
    ),
    GetPage(
      name: scanPage,
      page: () => const ScanPage(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: helpPage,
      page: () => const HelpPage(),
      binding: HelpBinding(),
    ),
  ];
}
