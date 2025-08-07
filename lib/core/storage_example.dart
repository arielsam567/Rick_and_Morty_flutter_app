import 'storage_impl.dart';
import 'dart:convert';

/// Exemplo de como usar o sistema de armazenamento local (apenas strings)
class StorageExample {
  /// Exemplo de como salvar e recuperar dados básicos
  static Future<void> exemploBasico() async {
    // Inicializar o storage
    final storage = await SharedPreferencesStorage.getInstance();

    // Salvar dados como strings
    await storage.setString('nome', 'Ricky e Martie');
    await storage.setString('idade', '25');
    await storage.setString('ativo', 'true');
    await storage.setString('altura', '1.75');

    // Recuperar dados
    final nome = await storage.getString('nome');
    final idade = await storage.getString('idade');
    final ativo = await storage.getString('ativo');
    final altura = await storage.getString('altura');

    print('Nome: $nome');
    print('Idade: $idade');
    print('Ativo: $ativo');
    print('Altura: $altura');
  }

  /// Exemplo de como trabalhar com JSON
  static Future<void> exemploJSON() async {
    final storage = await SharedPreferencesStorage.getInstance();

    // Salvar objeto como JSON string
    final usuario = {
      'nome': 'Ricky',
      'idade': 25,
      'ativo': true,
      'hobbies': ['música', 'esporte']
    };

    await storage.setString('usuario', json.encode(usuario));

    // Recuperar e decodificar JSON
    final usuarioString = await storage.getString('usuario');
    if (usuarioString != null) {
      final usuarioDecodificado = json.decode(usuarioString);
      print('Usuário: $usuarioDecodificado');
    }
  }

  /// Exemplo de como verificar se uma chave existe
  static Future<void> exemploVerificacao() async {
    final storage = await SharedPreferencesStorage.getInstance();

    // Verificar se uma chave existe
    final existe = await storage.containsKey('nome');
    print('Chave "nome" existe: $existe');

    // Listar todas as chaves
    final chaves = await storage.getKeys();
    print('Todas as chaves: $chaves');
  }

  /// Exemplo de como remover dados
  static Future<void> exemploRemocao() async {
    final storage = await SharedPreferencesStorage.getInstance();

    // Remover uma chave específica
    await storage.remove('nome');

    // Limpar todo o armazenamento
    // await storage.clear();
  }

  /// Exemplo de como usar o singleton de forma segura
  static Future<void> exemploSingleton() async {
    // Verificar se já foi inicializado
    if (SharedPreferencesStorage.isInitialized) {
      print('✅ Storage já foi inicializado');
    } else {
      print('⏳ Inicializando storage...');
    }

    // Obter instância
    final storage = await SharedPreferencesStorage.getInstance();

    // Verificar instância atual
    final instanciaAtual = SharedPreferencesStorage.currentInstance;
    print(
        'Instância atual: ${instanciaAtual != null ? "disponível" : "não disponível"}');
  }
}
