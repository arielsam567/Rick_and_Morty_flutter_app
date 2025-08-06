# Refatoração do RickAndMortyRepository

## 🎯 Objetivo

Refatorar o `RickAndMortyRepository` para usar uma abstração HTTP em vez do Dio diretamente, seguindo os princípios de Clean Architecture e Dependency Inversion Principle.

## 📋 Mudanças Realizadas

### 1. Criação da Abstração HTTP

**Arquivo:** `lib/core/network/http_client.dart`

```dart
/// Abstração para cliente HTTP
abstract class HttpClient {
  Future<HttpResponse> get(String path, {Map<String, dynamic>? queryParameters});
  Future<HttpResponse> post(String path, {dynamic data, Map<String, dynamic>? queryParameters});
  Future<HttpResponse> put(String path, {dynamic data, Map<String, dynamic>? queryParameters});
  Future<HttpResponse> delete(String path, {Map<String, dynamic>? queryParameters});
}

/// Resposta HTTP padronizada
class HttpResponse {
  final dynamic data;
  final int statusCode;
  final Map<String, dynamic>? headers;
  
  HttpResponse({
    required this.data,
    required this.statusCode,
    this.headers,
  });
}
```

### 2. Implementação do HttpClient com Dio

```dart
/// Implementação do HttpClient usando Dio
class DioHttpClient implements HttpClient {
  final Dio _dio;
  
  DioHttpClient(this._dio);
  
  @override
  Future<HttpResponse> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
        headers: response.headers.map,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
  
  // ... outros métodos
}
```

### 3. Refatoração do RickAndMortyRepository

**Antes:**
```dart
class RickAndMortyRepository {
  final Dio _dio;
  
  RickAndMortyRepository(this._dio);
  
  Future<PaginatedResponse<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await _dio.get('character', queryParameters: {'page': page});
      // ...
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }
}
```

**Depois:**
```dart
class RickAndMortyRepository {
  final HttpClient _httpClient;
  
  RickAndMortyRepository(this._httpClient);
  
  Future<PaginatedResponse<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await _httpClient.get('character', queryParameters: {'page': page});
      // ...
    } catch (e) {
      throw Exception('Erro ao buscar personagens: $e');
    }
  }
}
```

### 4. Atualização da Injeção de Dependência

**Arquivo:** `lib/providers/dependency_injection.dart`

```dart
class DependencyInjection {
  static List<Provider> providers = [
    // Provider para o Dio
    Provider<Dio>(
      create: (_) => DioConfig.createDio(),
    ),
    
    // Provider para o HttpClient (abstração)
    Provider<HttpClient>(
      create: (context) => DioHttpClient(context.read<Dio>()),
    ),
    
    // Provider para o RickAndMortyRepository (usando abstração)
    Provider<RickAndMortyRepository>(
      create: (context) => RickAndMortyRepository(context.read<HttpClient>()),
    ),
    
    // ... outros providers
  ];
}
```

## ✅ Vantagens da Refatoração

### 1. **Princípio da Inversão de Dependência**
- O repository não depende mais diretamente do Dio
- Depende de uma abstração (`HttpClient`)
- Facilita a troca de implementações

### 2. **Testabilidade**
```dart
// Agora é fácil criar um mock para testes
class MockHttpClient implements HttpClient {
  @override
  Future<HttpResponse> get(String path, {Map<String, dynamic>? queryParameters}) async {
    // Retorna dados mockados
    return HttpResponse(data: mockData, statusCode: 200);
  }
}

// Teste
final repository = RickAndMortyRepository(MockHttpClient());
```

### 3. **Flexibilidade**
- Pode trocar facilmente entre diferentes implementações HTTP
- Dio, http package, ou qualquer outra biblioteca
- Sem afetar o código do repository

### 4. **Separação de Responsabilidades**
- Repository: Lógica de negócio
- HttpClient: Abstração de comunicação HTTP
- DioHttpClient: Implementação específica do Dio

## 🔄 Como Usar

### 1. Acessando o Repository
```dart
// Em um widget
final repository = context.read<RickAndMortyRepository>();

// Buscando personagens
final response = await repository.getCharacters(page: 1);
```

### 2. Exemplo Completo
Veja o arquivo `lib/examples/repository_usage_example.dart` para um exemplo completo de uso.

## 🧪 Testes

### Exemplo de Teste Unitário
```dart
test('deve buscar personagens com sucesso', () async {
  // Arrange
  final mockHttpClient = MockHttpClient();
  final repository = RickAndMortyRepository(mockHttpClient);
  
  when(mockHttpClient.get(any, queryParameters: anyNamed('queryParameters')))
      .thenAnswer((_) async => HttpResponse(data: mockResponse, statusCode: 200));
  
  // Act
  final result = await repository.getCharacters(page: 1);
  
  // Assert
  expect(result.results.length, greaterThan(0));
});
```

## 📁 Estrutura de Arquivos

```
lib/
├── core/
│   └── network/
│       └── http_client.dart          # Nova abstração HTTP
├── repositories/
│   └── rickandmorty_repository.dart  # Refatorado
├── providers/
│   └── dependency_injection.dart     # Atualizado
└── examples/
    └── repository_usage_example.dart # Exemplo de uso
```

## 🎉 Resultado Final

O `RickAndMortyRepository` agora:
- ✅ Usa abstração HTTP em vez do Dio diretamente
- ✅ Segue os princípios de Clean Architecture
- ✅ É mais testável e flexível
- ✅ Mantém a mesma interface pública
- ✅ Facilita a manutenção e evolução do código 