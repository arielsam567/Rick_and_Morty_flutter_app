# Rick and Morty App - Estrutura Simplificada

## 🎯 Objetivo

Projeto simplificado com abstração do Dio e repository que retorna `Either`.

## 📁 Estrutura

```
lib/
├── core/
│   └── http_client.dart          # Abstração HTTP simples
├── repositories/
│   └── rickandmorty_repository.dart  # Repository com Either
├── providers/
│   └── dependency_injection.dart     # Injeção de dependência
├── examples/
│   └── simple_usage_example.dart     # Exemplo de uso
└── models/                          # Modelos de dados
```

## 🔧 Componentes Principais

### 1. HttpClient (Abstração)
```dart
abstract class HttpClient {
  Future<HttpResponse> get(String path, {Map<String, dynamic>? queryParameters});
}
```

### 2. RickAndMortyRepository
```dart
class RickAndMortyRepository {
  final HttpClient _httpClient;

  Future<Either<String, PaginatedResponse<Character>>> getCharacters({int page = 1}) async {
    // Retorna Either com sucesso ou erro
  }
}
```

### 3. Injeção de Dependência
```dart
class DependencyInjection {
  static List<Provider> providers = [
    Provider<Dio>(create: (_) => DioConfig.createDio()),
    Provider<HttpClient>(create: (context) => DioHttpClient(context.read<Dio>())),
    Provider<RickAndMortyRepository>(create: (context) => RickAndMortyRepository(context.read<HttpClient>())),
  ];
}
```

## 🔄 Como Usar

```dart
// Em um widget
final repository = context.read<RickAndMortyRepository>();

// Buscar personagens
final result = await repository.getCharacters();

result.fold(
  (error) {
    // Tratar erro
    print('Erro: $error');
  },
  (response) {
    // Usar dados
    print('Personagens: ${response.results.length}');
  },
);
```

## ✅ Vantagens

- ✅ **Simples**: Estrutura direta e fácil de entender
- ✅ **Abstração**: Dio encapsulado em HttpClient
- ✅ **Either**: Tratamento funcional de erros
- ✅ **Testável**: Fácil de mockar para testes
- ✅ **Flexível**: Pode trocar implementações HTTP

## 🧪 Exemplo de Teste

```dart
test('deve buscar personagens com sucesso', () async {
  final mockHttpClient = MockHttpClient();
  final repository = RickAndMortyRepository(mockHttpClient);
  
  when(mockHttpClient.get(any, queryParameters: anyNamed('queryParameters')))
      .thenAnswer((_) async => HttpResponse(data: mockData, statusCode: 200));
  
  final result = await repository.getCharacters();
  
  expect(result.isRight(), true);
  expect(result.fold((l) => null, (r) => r.results.length), greaterThan(0));
});
```

## 🎉 Resultado

Projeto limpo e simples com:
- Abstração do Dio ✅
- Repository com Either ✅
- Estrutura fácil de manter ✅ 