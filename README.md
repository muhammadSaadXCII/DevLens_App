# DevLens — AI-Powered Code Review Assistant

[![Flutter](https://img.shields.io/badge/Flutter-3.7.2+-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.7.2+-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![Riverpod](https://img.shields.io/badge/State-Riverpod-blue)](https://riverpod.dev/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Web-green)](https://flutter.dev/)

DevLens is a full-stack AI-powered code review assistant built with Flutter and Node.js. Paste your code, select from 37 supported languages, and instantly receive structured feedback on bugs, performance issues, security risks, and optimization suggestions — all powered by GPT-4o Mini through a secure backend API. The app features a split-panel interface with live syntax highlighting on the left and AI-generated Markdown feedback on the right, adapting seamlessly between mobile and desktop layouts. All AI requests are routed through a dedicated Node.js/Express backend with JWT authentication and rate limiting — keeping API keys off the client entirely.

---

## 🎥 Demo

https://github.com/user-attachments/assets/30a0778d-fd89-476c-bb77-6a3bee72f26a

---

## ✨ Features

- **AI Code Review** — Real-time feedback on bugs, security risks, performance, and code quality via GPT-4o Mini
- **37 Languages Supported** — JavaScript, TypeScript, Python, Dart, Java, Kotlin, Swift, Go, Rust, C/C++/C#, SQL, Bash, and more
- **Syntax Highlighting** — Live syntax highlighting powered by `code_text_field` and `highlight`
- **Split-Panel UI** — Code editor on the left, AI review rendered as Markdown on the right
- **Responsive Layout** — Adapts between vertical (mobile) and horizontal (desktop/web) layouts at 900px breakpoint
- **Secure Backend** — All AI requests route through a Node.js/Express API with JWT authentication and rate limiting — API keys never exposed in the client
- **Clean Architecture** — Strict separation into Data, Domain, and Presentation layers with Riverpod state management

---

## 🏗️ Architecture

```
lib/
├── main.dart                        # App entry point, Riverpod ProviderScope
├── data/
│   └── code_review_repo_impl.dart   # Dio HTTP client → Node.js backend
├── domain/
│   ├── models/
│   │   └── language.dart            # 37 supported language definitions
│   └── repositories/
│       └── code_review_repo.dart    # Abstract repository interface
└── presentation/
    ├── providers/
    │   ├── code_review_provider.dart # Riverpod StateNotifier
    │   └── code_review_state.dart    # Immutable state model
    ├── screens/
    │   └── code_review_screen.dart   # Main split-panel screen
    └── widgets/
        ├── code_panel.dart           # Syntax-highlighted code editor
        ├── review_panel.dart         # Markdown-rendered AI response
        └── language_dropdown.dart    # Language selector
```

**Data flow:** UI → Riverpod Provider → Repository → Node.js/Express API → GPT-4o Mini

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.7.2+ / Dart |
| State Management | Riverpod |
| HTTP Client | Dio |
| Code Editor | code_text_field + highlight |
| AI Response Rendering | flutter_markdown_plus |
| Backend | Node.js / Express (separate repo) |
| AI Model | GPT-4o Mini |
| Config | flutter_dotenv (.env) |

---

## 🔗 Repositories

| Repo | Description |
|------|-------------|
| [DevLens_App](https://github.com/muhammadSaadXCII/DevLens_App) | This Flutter frontend |
| [DevLens_API](https://github.com/muhammadSaadXCII/DevLens_API) | Node.js/Express backend with JWT auth and GPT-4o Mini integration |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.7.2+
- Dart SDK (bundled with Flutter)
- A running instance of [DevLens_API](https://github.com/muhammadSaadXCII/DevLens_API)

### Installation

```bash
# 1. Clone the repo
git clone https://github.com/muhammadSaadXCII/DevLens_App.git
cd DevLens_App

# 2. Install dependencies
flutter pub get
```

### Configuration

Create a `.env` file in the project root:

```
DEVLENS_API=https://your-backend-url/api/review
```

> ⚠️ Never commit your `.env` file. It's already listed in `.gitignore`.

### Run the App

```bash
# Android
flutter run

# Web
flutter run -d chrome
```

---

## 🔐 Security Notes

- The Flutter client never calls the AI API directly — all requests go through the Node.js backend
- The backend uses JWT authentication and rate limiting to prevent unauthorized access and API key abuse
- The `DEVLENS_API` endpoint URL is loaded from `.env` at runtime and never hardcoded
