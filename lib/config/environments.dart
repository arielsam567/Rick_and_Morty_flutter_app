/// Configurações de ambientes para a aplicação
///
/// Este arquivo permite configurar diferentes URLs base e outras configurações
/// para diferentes ambientes (desenvolvimento e produção)
class Environments {
  // URLs base para diferentes ambientes
  static const String _devBaseUrl = 'https://dev-api.exemplo.com/api/';
  static const String _prodBaseUrl = 'https://api.exemplo.com/api/';
  static const String _defaultBaseUrl = 'https://rickandmortyapi.com/api/';

  /// Ambiente atual da aplicação
  static const String _currentEnvironment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'default',
  );

  /// URL base configurada para o ambiente atual
  static String get baseUrl {
    switch (_currentEnvironment.toLowerCase()) {
      case 'dev':
      case 'development':
        return _devBaseUrl;
      case 'prod':
      case 'production':
        return _prodBaseUrl;
      case 'default':
      default:
        return _defaultBaseUrl;
    }
  }

  /// Retorna o nome do ambiente atual
  static String get environment => _currentEnvironment;

  /// Verifica se está em modo de desenvolvimento
  static bool get isDevelopment =>
      _currentEnvironment.toLowerCase() == 'dev' ||
      _currentEnvironment.toLowerCase() == 'development';

  /// Verifica se está em modo de produção
  static bool get isProduction =>
      _currentEnvironment.toLowerCase() == 'prod' ||
      _currentEnvironment.toLowerCase() == 'production';

  /// Retorna todas as configurações disponíveis
  static Map<String, String> get availableEnvironments => {
        'default': _defaultBaseUrl,
        'dev': _devBaseUrl,
        'prod': _prodBaseUrl,
      };
}
