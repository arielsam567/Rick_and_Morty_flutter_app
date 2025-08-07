class Environments {
  static const String _devBaseUrl = 'https://dev-api.exemplo.com/api/';
  static const String _prodBaseUrl = 'https://api.exemplo.com/api/';
  static const String _defaultBaseUrl = 'https://rickandmortyapi.com/api/';

  static const String _currentEnvironment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'default',
  );

  static String get baseUrl {
    switch (_currentEnvironment.toLowerCase()) {
      case 'dev':
        return _devBaseUrl;
      case 'prod':
        return _prodBaseUrl;
      case 'default':
      default:
        return _defaultBaseUrl;
    }
  }

  static String get environment => _currentEnvironment;

   
}
