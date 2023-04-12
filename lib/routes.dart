import 'package:flutter_application/pages/application/application.dart';
import 'package:flutter_application/pages/sign_in/sign_in.dart';
import 'package:flutter_application/pages/sign_up/sign_up.dart';

final staticRoutes = {
  "/sign-in": (context) => const SignInPage(),
  "/sign-up": (context) => const SignUpPage(),
  "/app-home": (context) => const ApplicationPage(), // 主程序
};
