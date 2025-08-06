# Rick and Morty App

Uma aplicação mobile desenvolvida em Flutter que consome a API do Rick and Morty para exibir informações sobre os personagens da série.

## 📱 Sobre o App

Este aplicativo permite aos usuários explorar o universo de Rick and Morty através de uma interface intuitiva e responsiva. O app consome a [Rick and Morty API](https://rickandmortyapi.com/) para fornecer informações detalhadas sobre os personagens da série.

## 🚀 Tecnologias Utilizadas

- **Flutter**: 3.29.2 (Stable Channel) 
- **Arquitetura**: MVVM (Model-View-ViewModel)

## 📋 Requisitos Funcionais

### ✅ Funcionalidades Implementadas

1. **Consumo da API Rick and Morty**
   - Integração com a API REST da Rick and Morty
   - Busca e exibição de dados dos personagens

2. **Listagem de Personagens**
   - Exibição de lista de personagens com nomes e imagens
   - Interface responsiva e otimizada para mobile

3. **Detalhes do Personagem**
   - Página de detalhes ao clicar em um personagem
   - Exibição de informações como:
     - **Nome** (name)
     - **Status** (status)
     - **Espécie** (species)

## 🏗️ Arquitetura

O projeto segue o padrão **MVVM (Model-View-ViewModel)** para garantir:
- Separação clara de responsabilidades
- Código legível e organizado
- Facilidade de manutenção e testes
- Boas práticas de desenvolvimento

## 📱 Usabilidade e Responsividade

- Interface adaptada para diferentes tamanhos de tela
- Navegação intuitiva entre telas
- Carregamento otimizado de imagens
- Feedback visual para ações do usuário

## 🛠️ Como Executar

### Pré-requisitos
- Flutter 3.27.1 ou superior
- Dart 3.6.0 ou superior

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
├── main.dart                 # Ponto de entrada da aplicação
├── models/                   # Modelos de dados
├── views/                    # Telas da aplicação
├── viewmodels/              # ViewModels (MVVM)
├── services/                 # Serviços de API
└── utils/                   # Utilitários e helpers
```

## 🔗 API Utilizada

- **Rick and Morty API**: https://rickandmortyapi.com/
- Documentação: https://rickandmortyapi.com/documentation

## 📄 Licença

Este projeto é desenvolvido para fins educacionais e de demonstração.

 
