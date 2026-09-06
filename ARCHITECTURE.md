# E-Commerce Clean Architecture Guide

This document defines the Clean Architecture pattern, naming conventions, layer responsibilities, and step-by-step guidelines for adding new features to this codebase.

---

## 🏛️ System Architecture Overview

The project uses a **Feature-First Clean Architecture** with **Bloc/Cubit** for state management and **Injectable + GetIt** for dependency injection.

```
lib/
├── core/
│   ├── di/                 # Dependency Injection (getIt, Injectable setup)
│   ├── routes/             # App Router (AppRouter abstract final class)
│   └── theme/              # AppColors (abstract final class) & AppTheme
│
├── features/
│   ├── common/             # Reusable widgets (AppButton, AppTextField, etc.) & utils
│   ├── network/            # Retrofit ApiServices, ApiResult, Models (Request/Response)
│   │
│   └── <feature_name>/     # e.g., auth, commerce, products, cart
│       ├── data/
│       │   └── repository/
│       │       ├── data_sources/       # RemoteDataSource & RemoteDataSourceImpl
│       │       └── <feature>_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── repository/             # Abstract Repository Interfaces
│       │   └── usecase/                # UseCase classes (@injectable)
│       │
│       └── ui/
│           └── screens/
│               └── <screen_name>/
│                   ├── cubit/          # <Screen>Cubit & <Screen>State
│                   └── <screen_name>_screen.dart
```

---

## 🧱 Layer Breakdown & Responsibilities

### 1. Network Layer (`lib/features/network/`)
- **`model/request/`**: Data Transfer Objects (DTOs) for API request payloads (`toJson`, `fromJson`).
- **`model/response/`**: DTOs for API response payloads.
- **`api/api_services.dart`**: Retrofit client defining HTTP endpoints (`@POST`, `@GET`, `@PUT`, `@DELETE`).
- **`api_result.dart`**: Sealed/discriminated union result type (`SuccessApiResult<T>` and `FailureApiResult<T>`).

### 2. Data Layer (`lib/features/<feature>/data/`)
- **`data_sources/`**:
  - `abstract class <Feature>RemoteDataSource`: Defines raw API interaction contracts returning `Future<ApiResult<T>>`.
  - `@Injectable(as: <Feature>RemoteDataSource)` `class <Feature>RemoteDataSourceImpl`: Implements the contract calling `ApiServices` inside `try-catch` with `handleDioError`.
- **`repository/`**:
  - `@Injectable(as: <Feature>Repository)` `class <Feature>RepositoryImpl`: Implements domain repository interface, calling data source methods and handling local persistence if needed.

### 3. Domain Layer (`lib/features/<feature>/domain/`)
- **`repository/`**:
  - `abstract class <Feature>Repository`: Pure Dart contract specifying business capabilities.
- **`usecase/`**:
  - `@injectable` `class <UseCaseName>UseCase`: Single responsibility class exposing a `call()` method that delegates to the domain repository.

### 4. Presentation / UI Layer (`lib/features/<feature>/ui/screens/<screen>/`)
- **`cubit/`**:
  - `<Screen>State`: Holds state objects wrapped in `Resource<T>` (`initial`, `loading`, `success`, `error`).
  - `@injectable` `class <Screen>Cubit extends Cubit<<Screen>State>`: Executes UseCases and emits updated state.
- **`<screen>_screen.dart`**:
  - Flutter UI Widget (`StatefulWidget` or `StatelessWidget`).
  - Utilizes reusable common widgets (`AppTextField`, `AppButton`, `AppColors`).
  - Uses `BlocBuilder` and `BlocListener` to react to state changes.

---

## ⚙️ Coding Standards & Conventions

1. **Colors**: Always defined in `lib/core/theme/colors.dart` as `abstract final class AppColors`.
2. **Themes**: Defined in `lib/core/theme/app_theme.dart` as `abstract final class AppTheme`.
3. **Router**: Routes defined in `lib/core/routes/app_router.dart` as `abstract final class AppRouter`.
4. **Common Widgets**: Place shared UI controls inside `lib/features/common/widgets/` (e.g. `AppTextField`, `AppButton`).
5. **Dependency Injection**: Always annotate implementations with `@Injectable(as: Interface)` and UseCases/Cubits with `@injectable`. Run `flutter pub run build_runner build --delete-conflicting-outputs` whenever injection signatures change.

---

## 📋 Checklist for Implementing a New Feature

When instructed to implement a new feature:

- [ ] **Step 1**: Create request and response models in `lib/features/network/model/`.
- [ ] **Step 2**: Add endpoint methods in `lib/features/network/api/api_services.dart`.
- [ ] **Step 3**: Define `RemoteDataSource` interface & implementation in `lib/features/<feature>/data/repository/data_sources/`.
- [ ] **Step 4**: Define `Repository` interface in `domain/repository/` and implement in `data/repository/`.
- [ ] **Step 5**: Create `@injectable` UseCase(s) in `domain/usecase/`.
- [ ] **Step 6**: Create State & `@injectable` Cubit in `ui/screens/<screen>/cubit/`.
- [ ] **Step 7**: Implement Screen UI in `ui/screens/<screen>/<screen>_screen.dart`.
- [ ] **Step 8**: Add route to `lib/core/routes/app_router.dart`.
- [ ] **Step 9**: Run `flutter pub run build_runner build --delete-conflicting-outputs` to regenerate Retrofit & GetIt bindings.
- [ ] **Step 10**: Verify with `flutter analyze` and `flutter build apk --debug`.
