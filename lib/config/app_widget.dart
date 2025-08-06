import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/config/strings.dart';
import 'package:ricky_and_martie_app/config/themes/custom_themes.dart';
import 'package:ricky_and_martie_app/services/routes.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Strings.appName,
      theme: CustomThemes().defaultTheme,
      routerConfig: AppRouter.router,
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
