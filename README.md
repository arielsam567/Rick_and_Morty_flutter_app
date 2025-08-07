# Rick and Morty App

Uma aplicação mobile desenvolvida em Flutter que consome a API do Rick and Morty para exibir informações sobre os personagens da série.

## 📱 Sobre o App

Este aplicativo permite aos usuários explorar o universo de Rick and Morty através de uma interface intuitiva e responsiva. O app consome a [Rick and Morty API](https://rickandmortyapi.com/) para fornecer informações detalhadas sobre os personagens da série.

## 🚀 Tecnologias Utilizadas

- **Flutter**: 3.29.2 (Stable Channel) 
- **Dart SDK**: ^3.6.0 
- **Gerenciamento de Estado**: Provider
- **Navegação**: Go Router
- **HTTP Client**: Dio
- **Cache de Imagens**: Cached Network Image
- **Loading States**: Shimmer 

## 📋 Requisitos Funcionais

### ✅ Funcionalidades Implementadas

1. **Consumo da API Rick and Morty**
   - Integração com a API REST da Rick and Morty
   - Busca e exibição de dados dos personagens
   - Paginação automática

2. **Listagem de Personagens**
   - Exibição de lista de personagens com nomes e imagens
   - Interface responsiva e otimizada para mobile

3. **Detalhes do Personagem**
   - Página de detalhes ao clicar em um personagem
   - Exibição de informações como:
     - **Nome** (name)
     - **Status** (status) com indicador visual
     - **Espécie** (species)


 

### Camadas da Arquitetura:
- **Presentation Layer**: Pages, Controllers, Widgets
- **Domain Layer**: Use Cases, Entities
- **Data Layer**: Repositories, Services


## 🛠️ Como Executar

### Pré-requisitos
- Flutter 3.29.2 ou superior 
- Dart SDK ^3.6.0

### Instalação
```bash
# Clone o repositório
git clone [URL_DO_REPOSITORIO]

# Navegue para o diretório do projeto
cd ricky_and_martie_app

# Instale as dependências
flutter pub get

# Execute o aplicativo
flutter run
```

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── config/                      # Configurações do app
│   ├── app_widget.dart         # Widget principal
│   ├── assets.dart             # Configuração de assets
│   ├── dio_config.dart         # Configuração do HTTP client
│   ├── strings.dart            # Strings da aplicação
│   └── themes/                 # Temas e cores
├── core/                       # Camada de domínio
│   ├── error/                  # Tratamento de erros
│   ├── http_client.dart        # Cliente HTTP
│   ├── network/                # Configurações de rede
│   └── usecases/               # Casos de uso
├── models/                     # Modelos de dados
│   ├── character.dart          # Modelo de personagem
│   └── paginated_response.dart # Resposta paginada
├── pages/                      # Telas da aplicação
│   ├── home/                   # Página inicial
│   └── details/                # Página de detalhes
├── providers/                  # Gerenciamento de estado
│   └── dependency_injection.dart
├── repositories/               # Repositórios de dados
│   └── rickandmorty_repository.dart
├── services/                   # Serviços
│   └── routes.dart             # Configuração de rotas
└── widgets/                    # Widgets reutilizáveis
    ├── character_card.dart     # Card de personagem
    ├── character_image_widget.dart
    ├── status_indicator.dart   # Indicador de status
    ├── gender_indicator.dart   # Indicador de gênero
    ├── shimmer/                # Estados de loading
    └── error/                  # Widgets de erro
```

## 📦 Dependências Principais

- **dio**: ^5.8.0+1 - Cliente HTTP
- **cached_network_image**: ^3.4.1 - Cache de imagens
- **shimmer**: ^3.0.0 - Efeitos de loading
- **go_router**: ^16.1.0 - Navegação
- **provider**: ^6.1.5 - Gerenciamento de estado
- **dartz**: ^0.10.1 - Programação funcional
- **equatable**: ^2.0.5 - Comparação de objetos

## 🔗 API Utilizada

- **Rick and Morty API**: https://rickandmortyapi.com/
- Documentação: https://rickandmortyapi.com/documentation

## 📄 Licença

Este projeto é desenvolvido para fins educacionais e de demonstração.

 
