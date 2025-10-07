## 🛸 Rick & Morty BLoC — Intermediate Guide

A clean, production-ready Flutter app that showcases the Rick and Morty universe with a feature-based architecture, robust state management using BLoC, dependency injection, code generation, and persistent theming. Built for learning and as a solid starter for scalable apps.

---

### 📦 Tech Stack & Packages
- **Flutter**: Material design, custom fonts, assets
- **State Management**: `flutter_bloc`, `hydrated_bloc`
- **Networking**: `dio`
- **DI/Service Locator**: `get_it`
- **Functional utils**: `fpdart`
- **Modeling/Codegen**: `json_annotation`, `json_serializable`, `build_runner`
- **Device Storage**: `path_provider` (for Hydrated storage)
- **Animations**: `lottie`

---

### 🧭 Overview
- **Three core features**: Characters, Episodes, Locations
- **API**: `https://rickandmortyapi.com/api/`
- **Offline UX**: Theme persistence with `hydrated_bloc`
- **UI/UX**: Custom `Roboto` font family, Lottie loading animations

---

### 🧱 Architecture (Feature-First)
- **Feature Modules**: Each feature owns its `bloc`, `data_sources`, `models`, `repositories`, `screens`, `widgets`
- **BLoC**: Event → Bloc → State flow per feature (`CharactersBloc`, `EpisodesBloc`, `LocationsBloc`)
- **Data Layer**: `RemoteDataSource` (Dio) → `Repository` → `Bloc`
- **Dependency Injection**: `get_it` service locator in `injection_container.dart`
- **Core Layer**: Shared UI, constants, theming, and app-wide cubits (e.g., `MainCubit` for theme)

---

### 🗂️ Project Structure
```
lib/
  core/
    cubits/main/                # App-wide cubits (theme)
    utils/
      config/theme/             # Light/Dark themes
      constants/                # Colors, icons, sizes, texts, urls
      widgets/                  # Shared UI components
  features/
    characters/                 # Characters feature (bloc, data, repo, UI)
    episodes/                   # Episodes feature (bloc, data, repo, UI)
    locations/                  # Locations feature (bloc, data, repo, UI)
  injection_container.dart      # DI registrations (get_it)
  main.dart                     # App bootstrap (Hydrated storage, theme, root)
  main_screen.dart              # App shell / navigation
assets/
  animations/                   # Lottie files
  fonts/                        # Roboto font family
```

---

### 🧩 Key Concepts
- **Hydrated BLoC**: Persists states like theme across app restarts
- **Dio + Repositories**: Network access via repositories abstracting data sources
- **GetIt**: Simple, centralized dependency graph
- **JSON Codegen**: Fast, type-safe model serialization

---

### 🚀 Getting Started
1) Ensure Flutter SDK is installed and Dart >= 3.4.0
2) Install dependencies
```bash
flutter pub get
```
3) Generate JSON models (when you modify models)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
4) Run the app
```bash
flutter run
```

---

### 🧪 Environments & Platforms
- iOS and Android supported (default Flutter targets)
- Uses application documents directory for Hydrated storage

---

### 🎛️ Theming
- Light and Dark themes under `core/utils/config/theme`
- `MainCubit` controls the active theme and persists it via `hydrated_bloc`

---

### 🔌 Dependency Injection
- All dependencies are registered in `injection_container.dart` using `get_it`
- Includes HTTP client (`Dio`), feature blocs, repositories, and data sources

---

### 🌐 API
- Base URL: `https://rickandmortyapi.com/api/`
- Helper: `RMUrls.constructUrl(feature: ..., pageIndex: ...)`

---

### ✨ Features
- **Characters**: List + detail using `CharactersBloc`
- **Episodes**: List + detail using `EpisodesBloc`
- **Locations**: List + detail using `LocationsBloc`
- **Loading Animations**: Lottie-driven UX polish

---

### 🛠️ Scripts & Tips
- Regenerate code after model changes:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
- Clean build cache if needed:
```bash
flutter clean && flutter pub get
```

---

### 🤝 Contributing
Pull requests are welcome. Please keep changes consistent with the architecture (feature-first, repository pattern, BLoC state management) and run code generation if you add/modify models.

---

### 📜 License
This project is provided for educational purposes. Add a license file if you plan to distribute.

---

### 👤 Author
- Maintained by the project owner. Contributions and feedback are appreciated!
