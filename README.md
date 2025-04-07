## 🧠 Buscar Usuário - Flutter + ReqRes API

Este é um aplicativo Flutter simples que consome a API pública [ReqRes](https://reqres.in) para buscar informações de um usuário a partir do seu ID.

### 📱 Funcionalidades

- Campo de texto para digitar o ID do usuário (entre 1 e 12).
- Botão "Buscar" para iniciar a requisição.
- Requisição `GET` para `https://reqres.in/api/users/{id}`.
- Exibe:
  - Foto
  - Nome completo
  - E-mail
- Trata:
  - IDs inválidos
  - Usuário não encontrado (404)
  - Erros de conexão ou API

### 💻 Tecnologias

- Flutter
- Dart
- HTTP (pacote: `http`)
- JSON parsing
- Material Design

### 🗂 Estrutura (versão simplificada)

```
lib/
├── main.dart  # Código completo do app (em versão única)
```

### 🧪 Como Rodar

1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/busca-usuario-flutter.git
cd busca-usuario-flutter
```

2. Instale as dependências:

```bash
flutter pub get
```

3. Execute o app:

```bash
flutter run
```

> Obs: Certifique-se de estar com um emulador Android ou iOS rodando, ou um dispositivo conectado.

---

### 📸 Preview

![Fluxo da Lógica do App](lib/assets/demo.png) <!-- (adicione a imagem gerada no repositório como `flowchart.png`) -->

---
