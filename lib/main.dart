import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:ricky_and_martie_app/config/app_widget.dart';
import 'package:ricky_and_martie_app/config/environments.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  setUrlStrategy(PathUrlStrategy());

  // Log do ambiente atual para debug
  debugPrint('🔧 Ambiente atual: ${Environments.environment}');
  debugPrint('🔧 URL base configurada: ${Environments.baseUrl}');

  runApp(const AppWidget());
}
