import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'storage_abstract.dart';

class SharedPreferencesStorage implements StorageService {
  static SharedPreferencesStorage? _instance;
  static SharedPreferences? _prefs;

  // Construtor privado para implementar o padrão Singleton
  SharedPreferencesStorage._();

  /// Retorna a instância única do SharedPreferencesStorage
  static Future<SharedPreferencesStorage> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesStorage._();
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  /// Retorna a instância atual (pode ser null se não foi inicializada)
  static SharedPreferencesStorage? get currentInstance => _instance;

  /// Verifica se a instância foi inicializada
  static bool get isInitialized => _instance != null && _prefs != null;

  /// Força a reinicialização da instância (útil para testes)
  static void reset() {
    _instance = null;
    _prefs = null;
  }

  @override
  Future<bool> setString(String key, String value) async {
    try {
      if (_prefs == null) {
        debugPrint('❌ SharedPreferences não foi inicializado');
        return false;
      }
      return await _prefs!.setString(key, value);
    } catch (e) {
      debugPrint('❌ Erro ao salvar string: $e');
      return false;
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      if (_prefs == null) {
        debugPrint('❌ SharedPreferences não foi inicializado');
        return null;
      }
      return _prefs!.getString(key);
    } catch (e) {
      debugPrint('❌ Erro ao recuperar string: $e');
      return null;
    }
  }

  @override
  Future<bool> remove(String key) async {
    try {
      if (_prefs == null) {
        debugPrint('❌ SharedPreferences não foi inicializado');
        return false;
      }
      return await _prefs!.remove(key);
    } catch (e) {
      debugPrint('❌ Erro ao remover chave: $e');
      return false;
    }
  }

  @override
  Future<bool> clear() async {
    try {
      if (_prefs == null) {
        debugPrint('❌ SharedPreferences não foi inicializado');
        return false;
      }
      return await _prefs!.clear();
    } catch (e) {
      debugPrint('❌ Erro ao limpar armazenamento: $e');
      return false;
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    try {
      if (_prefs == null) {
        debugPrint('❌ SharedPreferences não foi inicializado');
        return false;
      }
      return _prefs!.containsKey(key);
    } catch (e) {
      debugPrint('❌ Erro ao verificar chave: $e');
      return false;
    }
  }

  @override
  Future<Set<String>> getKeys() async {
    try {
      if (_prefs == null) {
        debugPrint('❌ SharedPreferences não foi inicializado');
        return <String>{};
      }
      return _prefs!.getKeys();
    } catch (e) {
      debugPrint('❌ Erro ao recuperar chaves: $e');
      return <String>{};
    }
  }
}
