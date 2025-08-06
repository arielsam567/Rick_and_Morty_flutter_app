# Clean Architecture com Dartz - Rick and Morty App

## 🏗️ Arquitetura Implementada

Este projeto agora segue os princípios da **Clean Architecture** com **dartz** para tratamento funcional de erros.

### Estrutura de Camadas

```
lib/
├── core/                           # Camada central
│   ├── error/
│   │   └── failures.dart          # Abstração de erros
│   └── usecases/
│       └── usecase.dart           # UseCase base
├── features/                       # Features do app
│   └── characters/                # Feature de personagens
│       ├── domain/                # Regras de negócio
│       │   ├── entities/
│       │   │   └── character.dart
│       │   ├── repositories/
│       │   │   └── character_repository.dart
│       │   └── usecases/
│       │       ├── get_characters.dart
│       │       └── get_character_by_id.dart
│       └── data/                  # Implementação
│           ├── models/
│           │   ├── character_model.dart
│           │   └── paginated_response_model.dart
│           ├── datasources/
│           │   └── character_remote_data_source.dart
│           └── repositories/
│               └── character_repository_impl.dart
└── config/                        # Configurações
    └── dio_config.dart
```

## 🎯 Vantagens da Nova Arquitetura

### 1. **Separação de Responsabilidades**
- **Domain**: Regras de negócio puras
- **Data**: Implementação de dados
- **Presentation**: Interface do usuário

### 2. **Tratamento Funcional de Erros**
```dart
// Antes (try/catch)
try {
  final characters = await repository.getCharacters();
  // usar characters
} catch (e) {
  // tratar erro
}

// Agora (dartz)
final result = await getCharacters(params);
result.fold(
  (failure) => // tratar erro,
  (characters) => // usar characters
);
```

### 3. **Testabilidade**
- Cada camada pode ser testada independentemente
- Fácil mockar dependências
- Testes mais isolados e confiáveis

### 4. **Injeção de Dependência Limpa**
```dart
// UseCase recebe Repository
class GetCharacters implements UseCase<List<Character>, GetCharactersParams> {
  final CharacterRepository repository;
  GetCharacters(this.repository);
}

// Repository recebe DataSource
class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  CharacterRepositoryImpl(this.remoteDataSource);
}
```

## 🔄 Fluxo de Dados

```
UI → UseCase → Repository → DataSource → API
```

### Exemplo de Uso:

```dart
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _loadCharacters() async {
    final getCharacters = context.read<GetCharacters>();
    final result = await getCharacters(const GetCharactersParams(page: 1));

    result.fold(
      (failure) {
        // Tratar erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (characters) {
        // Usar dados
        setState(() {
          this.characters = characters;
        });
      },
    );
  }
}
```

## 🧪 Testes

### Teste de UseCase:
```dart
test('Deve retornar lista de personagens quando sucesso', () async {
  // Arrange
  final mockRepository = MockCharacterRepository();
  final useCase = GetCharacters(mockRepository);
  
  when(mockRepository.getCharacters(page: 1))
    .thenAnswer((_) async => Right([Character(...)]));
  
  // Act
  final result = await useCase(const GetCharactersParams(page: 1));
  
  // Assert
  expect(result.isRight(), true);
  result.fold(
    (failure) => fail('Não deveria falhar'),
    (characters) => expect(characters.length, 1),
  );
});
```

### Teste de Repository:
```dart
test('Deve retornar ServerFailure quando API falha', () async {
  // Arrange
  final mockDataSource = MockCharacterRemoteDataSource();
  final repository = CharacterRepositoryImpl(mockDataSource);
  
  when(mockDataSource.getCharacters(page: 1))
    .thenThrow(DioException(...));
  
  // Act
  final result = await repository.getCharacters(page: 1);
  
  // Assert
  expect(result.isLeft(), true);
  result.fold(
    (failure) => expect(failure, isA<ServerFailure>()),
    (characters) => fail('Não deveria ter sucesso'),
  );
});
```

## 📦 Dependências Adicionadas

- **dartz**: Para programação funcional e Either
- **equatable**: Para comparação de objetos (opcional)

## 🚀 Próximos Passos

1. **Implementar cache local** com Hive ou SharedPreferences
2. **Adicionar mais features** (episódios, localizações)
3. **Implementar testes unitários** para cada camada
4. **Adicionar bloc/cubit** para gerenciamento de estado
5. **Implementar paginação** com scroll infinito

## 💡 Benefícios

- **Código mais limpo** e organizado
- **Fácil manutenção** e evolução
- **Testes mais confiáveis**
- **Tratamento robusto de erros**
- **Separação clara de responsabilidades**
- **Reutilização de código** 