import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/config/app_widget.dart';
import 'package:ricky_and_martie_app/config/environments.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  debugPrint('🔧 Ambiente atual: ${Environments.environment}');
  debugPrint('🔧 URL base configurada: ${Environments.baseUrl}');

  runApp(const AppWidget());
}
