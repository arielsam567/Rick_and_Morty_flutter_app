import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:ricky_and_martie_app/core/storage/storage_abstract.dart';

class LocalStorageService implements StorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _prefs;

  LocalStorageService._();

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService._();
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  static LocalStorageService? get currentInstance => _instance;

  static bool get isInitialized => _instance != null && _prefs != null;

  static void reset() {
    _instance = null;
    _prefs = null;
  }

  @override
  Future<bool> setString(String key, String value) async {
    try {
      if (_prefs == null) {
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
        return false;
      }
      return await _prefs!.remove(key);
    } catch (e) {
      debugPrint('❌ Erro ao remover chave: $e');
      return false;
    }
  }
}
