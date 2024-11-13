import 'package:qlevar_router/qlevar_router.dart';
import 'package:skeleton/home/presentation/pages/home_page.dart' as home_page;
import 'package:skeleton/authentication/presentation/pages/onboarding_page.dart'
    deferred as onboarding_page;
import 'package:skeleton/authentication/presentation/pages/passcode_page.dart'
    deferred as passcode_page;
import 'package:skeleton/authentication/presentation/pages/register_page.dart'
    deferred as register_page;
import 'package:skeleton/home/presentation/pages/input_result_page.dart'
    deferred as input_result_page;
import 'package:skeleton/home/presentation/pages/edit_profile_page.dart'
    deferred as edit_profile_page;
import 'package:skeleton/home/presentation/pages/history_input_page.dart'
    deferred as history_input_page;
import 'deferred_loader.dart';

class AppRoutes {
  static const rootPath = "/";
  static const passcodePath = "/passcode";
  static const registerPath = "/register";
  static const editProfilePath = "/edit-profile";
  static const inputResultPath = "/input-result";
  static const homePath = "/home-dashboard";
  static const historyInputPath = "/input-history";
  static final routes = [
    QRoute(
      path: historyInputPath,
      builder: () => history_input_page.HistoryInputPage(),
      middleware: [
        DeferredLoader(history_input_page.loadLibrary),
      ]
    ),
    QRoute(
      path: editProfilePath,
      builder: () => edit_profile_page.EditProfilePage(),
      middleware: [
        DeferredLoader(edit_profile_page.loadLibrary),
      ],
    ),
    QRoute(
      path: inputResultPath,
      builder: () => input_result_page.InputResultPage(),
      middleware: [
        DeferredLoader(input_result_page.loadLibrary),
      ],
    ),
    QRoute(
      path: registerPath,
      builder: () => register_page.RegisterPage(),
      middleware: [
        DeferredLoader(register_page.loadLibrary),
      ],
    ),
    QRoute(
      path: passcodePath,
      builder: () => passcode_page.PasscodePage(),
      middleware: [
        DeferredLoader(passcode_page.loadLibrary),
      ],
    ),
    QRoute(
      path: rootPath,
      builder: () => onboarding_page.OnboardingPage(),
      middleware: [
        DeferredLoader(onboarding_page.loadLibrary),
      ],
    ),
    QRoute(
      path: homePath,
      builder: () => const home_page.HomePage(),
    ),
  ];
}
