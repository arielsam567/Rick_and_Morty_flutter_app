import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_wickedbotz/config/strings.dart';
import 'package:site_wickedbotz/config/themes/custom_themes.dart';
import 'package:site_wickedbotz/services/routes.dart';
import 'package:site_wickedbotz/services/storage.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (context) {
    //         Storage.init();
    //       },
    //       lazy: false,
    //     ),
    //   ],
    //   child: MaterialApp(
    //     title: Strings.appName,
    //     theme: CustomThemes().defaultTheme,
    //     routes: Routes().routes(context),
    //     onGenerateInitialRoutes: (initialRoute) => [
    //       Routes.generateRoute(RouteSettings(name: initialRoute))!,
    //     ],
    //     onGenerateRoute: Routes.generateRoute,
    //     navigatorKey: Routes.navigator,
    //     scaffoldMessengerKey: scaffoldMessengerKey,
    //     debugShowCheckedModeBanner: false,
    //   ),
    // );
  }
}
