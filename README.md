# Dev Lens

[![Flutter Version](https://img.shields.io/badge/Flutter-3.9.0-blue.svg)](https://flutter.dev/)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A smart code review assistant powered by generative AI.

## 🚀 Project Overview

Dev Lens is a Flutter application that helps developers get instant feedback on their code. It leverages AI to provide suggestions, identify potential bugs, and offer improvements for better code quality.

### ✨ Key Features

*   **AI-Powered Code Review:** Get intelligent feedback on your code.
*   **Syntax Highlighting:** View code with proper highlighting for better readability.
*   **Language Support:** Supports multiple programming languages for code review.

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

*   [Flutter SDK](https://flutter.dev/docs/get-started/install) (Version 3.9.0 or higher)
*   [Dart SDK](https://dart.dev/get-dart)
*   A code editor like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

## 📦 Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/muhammadSaadXCII/dev-lens.git
    cd dev-lens
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

## 🏃 Running the App

To run the application, use the following command:

```bash
flutter run
```

## 📂 Project Structure

The project follows a feature-driven architecture to maintain a clean and scalable codebase.

```
lib/
├── data/
│   └── code_review_repo_impl.dart
├── domain/
│   ├── models/
│   │   └── language.dart
│   └── repositories/
│       └── code_review_repo.dart
├── presentation/
│   ├── providers/
│   │   ├── code_review_provider.dart
│   │   └── code_review_state.dart
│   ├── screens/
│   │   └── code_review_screen.dart
│   └── widgets/
│       ├── code_panel.dart
│       ├── language_dropdown.dart
│       └── review_panel.dart
└── main.dart
```

*   `data`: Contains the implementation of the repositories defined in the domain layer.
*   `domain`: The core of the application, containing business logic and models.
*   `presentation`: Contains the UI of the application (screens, widgets, and providers).
*   `main.dart`: The entry point of the application.
