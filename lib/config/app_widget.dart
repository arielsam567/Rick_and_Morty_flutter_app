import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/config/strings.dart';
import 'package:ricky_and_martie_app/config/themes/custom_themes.dart';
import 'package:ricky_and_martie_app/providers/dependency_injection.dart';
import 'package:ricky_and_martie_app/infrastructure/routes/routes.dart';
import 'package:provider/single_child_widget.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: DependencyInjection.providers.cast<SingleChildWidget>(),
      child: MaterialApp.router(
        title: Strings.appName,
        theme: CustomThemes().defaultTheme,
        routerConfig: AppRouter.router,
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
