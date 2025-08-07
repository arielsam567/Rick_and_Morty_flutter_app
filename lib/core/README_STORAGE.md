# Sistema de Armazenamento Local

Este sistema fornece uma abstração para o armazenamento local usando SharedPreferences como singleton, trabalhando apenas com strings.

## Arquivos

- `storage_abstract.dart` - Interface/abstração do sistema de armazenamento
- `storage_impl.dart` - Implementação usando SharedPreferences como singleton
- `storage_example.dart` - Exemplos de uso
- `http_client_impl.dart` - Atualizado para usar o novo sistema

## Como usar

### 1. Inicialização

```dart
// Obter a instância do storage
final storage = await SharedPreferencesStorage.getInstance();
```

### 2. Operações básicas

```dart
// Salvar dados como strings
await storage.setString('chave', 'valor');
await storage.setString('numero', '42');
await storage.setString('ativo', 'true');
await storage.setString('preco', '19.99');

// Recuperar dados
final valor = await storage.getString('chave');
final numero = await storage.getString('numero');
final ativo = await storage.getString('ativo');
final preco = await storage.getString('preco');
```

### 3. Trabalhando com JSON

```dart
// Salvar objeto como JSON string
final usuario = {
  'nome': 'Ricky',
  'idade': 25,
  'ativo': true
};
await storage.setString('usuario', json.encode(usuario));

// Recuperar e decodificar JSON
final usuarioString = await storage.getString('usuario');
if (usuarioString != null) {
  final usuarioDecodificado = json.decode(usuarioString);
  print('Usuário: $usuarioDecodificado');
}
```

### 4. Verificações e limpeza

```dart
// Verificar se uma chave existe
final existe = await storage.containsKey('chave');

// Listar todas as chaves
final chaves = await storage.getKeys();

// Remover uma chave específica
await storage.remove('chave');

// Limpar todo o armazenamento
await storage.clear();
```

### 5. Verificações do Singleton

```dart
// Verificar se já foi inicializado
if (SharedPreferencesStorage.isInitialized) {
  print('Storage já foi inicializado');
}

// Obter instância atual (pode ser null)
final instanciaAtual = SharedPreferencesStorage.currentInstance;

// Forçar reinicialização (útil para testes)
SharedPreferencesStorage.reset();
```

## Vantagens do Singleton

1. **Performance**: Evita múltiplas inicializações do SharedPreferences
2. **Memória**: Mantém apenas uma instância em memória
3. **Consistência**: Garante que todos os lugares usem a mesma instância
4. **Thread-safe**: Implementação segura para uso em múltiplas threads

## Tratamento de Erros

O sistema inclui tratamento de erros robusto:

- Verifica se o SharedPreferences foi inicializado
- Captura e loga erros de operações
- Retorna valores padrão em caso de falha
- Mensagens de debug para facilitar troubleshooting

## Integração com HTTP Client

O `http_client_impl.dart` foi atualizado para usar o novo sistema:

```dart
// Antes
final prefs = await SharedPreferences.getInstance();
final data = prefs.getString('chave');

// Depois
final storage = await SharedPreferencesStorage.getInstance();
final data = await storage.getString('chave');
```

## Exemplos de Uso

Veja o arquivo `storage_example.dart` para exemplos completos de uso.

## Simplificação

O sistema foi simplificado para trabalhar apenas com strings, o que oferece:

- **Simplicidade**: Interface mais limpa e fácil de usar
- **Flexibilidade**: Qualquer tipo de dado pode ser convertido para string
- **JSON**: Fácil serialização/deserialização de objetos complexos
- **Compatibilidade**: Funciona com qualquer tipo de dado através de conversão 