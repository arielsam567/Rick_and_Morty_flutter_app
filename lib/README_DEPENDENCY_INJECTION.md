# Injeção de Dependência - Rick and Morty App

## Configuração

Este projeto utiliza injeção de dependência com o Provider para gerenciar as dependências do Dio e Repository.

### Estrutura de Arquivos

```
lib/
├── config/
│   └── dio_config.dart          # Configuração do Dio
├── models/
│   ├── character.dart           # Modelo de personagem
│   └── paginated_response.dart  # Modelo de resposta paginada
├── providers/
│   └── dependency_injection.dart # Configuração dos providers
├── repositories/
│   └── rickandmorty_repository.dart # Repository da API
└── main.dart                    # Configuração inicial
```

## Como Usar

### 1. Acessando o Repository em um Widget

```dart
import 'package:provider/provider.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';

class MeuWidget extends StatefulWidget {
  @override
  State<MeuWidget> createState() => _MeuWidgetState();
}

class _MeuWidgetState extends State<MeuWidget> {
  Future<void> _carregarPersonagens() async {
    try {
      // Acessando o repository através do Provider
      final repository = context.read<RickAndMortyRepository>();
      
      // Buscando personagens
      final response = await repository.getCharacters(page: 1);
      
      // Usando os dados
      print('Total de personagens: ${response.results.length}');
    } catch (e) {
      print('Erro: $e');
    }
  }
}
```

### 2. Métodos Disponíveis no Repository

#### Buscar todos os personagens (com paginação)
```dart
final response = await repository.getCharacters(page: 1);
```

#### Buscar personagem por ID
```dart
final character = await repository.getCharacterById(1);
```

#### Buscar personagens por nome
```dart
final response = await repository.searchCharactersByName('Rick');
```

#### Buscar múltiplos personagens por IDs
```dart
final characters = await repository.getCharactersByIds([1, 2, 3]);
```

### 3. Tratamento de Erros

O repository inclui tratamento automático de erros para:
- Timeout de conexão
- Erros de rede
- Erros HTTP (404, 500, etc.)
- Requisições canceladas

### 4. Configuração do Dio

O Dio está configurado com:
- Base URL: `https://rickandmortyapi.com/api/`
- Timeout: 30 segundos
- Headers padrão para JSON
- Logs de requisição e resposta
- Interceptors para tratamento global de erros

## Vantagens da Injeção de Dependência

1. **Testabilidade**: Fácil de mockar para testes
2. **Flexibilidade**: Pode trocar implementações facilmente
3. **Reutilização**: Mesma instância em toda a aplicação
4. **Manutenibilidade**: Código mais limpo e organizado

## Exemplo de Teste

```dart
// Em um teste, você pode mockar o repository
testWidgets('Deve carregar personagens', (WidgetTester tester) async {
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        Provider<RickAndMortyRepository>(
          create: (_) => MockRepository(),
        ),
      ],
      child: MaterialApp(home: HomePage()),
    ),
  );
});
``` 