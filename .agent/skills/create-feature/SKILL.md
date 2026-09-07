---
name: create-feature
description: >-
  Guide and step-by-step workflow for implementing a new feature in this e-commerce codebase
  adhering to Feature-First Clean Architecture (Bloc/Cubit, Retrofit, Injectable/GetIt, Mappers).
---

# Feature Creation Skill (`create-feature`)

Use this skill when tasked with building a new feature or extending existing feature modules in this project.
This guide ensures strict adherence to the project's **Feature-First Clean Architecture**, state management patterns, data mapping rules, and dependency injection conventions as documented in [ARCHITECTURE.md](file:///Users/ahmednabil/StudioProjects/ecommerce_c19/ARCHITECTURE.md).

---

## 🏛️ Architecture Overview & Directory Structure

New features are located in `lib/features/<feature_name>/`:

```
lib/
├── core/
│   ├── di/                 # Injectable & GetIt setup
│   ├── routes/             # AppRouter (abstract final class)
│   └── theme/              # AppColors (abstract final class) & AppTheme
│
├── features/
│   ├── common/             # Shared UI widgets (AppButton, AppTextField) & utils
│   ├── network/            # Retrofit ApiServices, ApiResult, Models (Request/Response)
│   │
│   └── <feature_name>/     # e.g., auth, commerce, products, cart, profile
│       ├── data/
│       │   ├── mapper/                 # Mappers (@injectable concrete classes)
│       │   └── repository/
│       │       ├── data_sources/       # RemoteDataSource & RemoteDataSourceImpl
│       │       └── <feature>_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entity/                 # Domain Entities (Non-nullable business models)
│       │   ├── repository/             # Abstract Repository Interface
│       │   └── usecase/                # Single-responsibility UseCases (@injectable)
│       │
│       └── ui/
│           └── screens/
│               └── <screen_name>/
│                   ├── cubit/          # <Screen>Cubit & <Screen>State
│                   └── <screen_name>_screen.dart
```

---

## ⚙️ Step-by-Step Implementation Workflow

Follow these steps sequentially when building a feature:

### Step 1: Request & Response Models (DTOs)
Location: `lib/features/network/model/`
- Request models go in `request/<model_name>_request.dart`.
- Response models go in `response/<model_name>_response.dart`.
- Include `toJson()` and `fromJson()` factory methods.

### Step 2: Retrofit API Endpoint Setup
Location: `lib/features/network/api/api_services.dart`
- Declare the endpoint method in `ApiServices` abstract class with appropriate Retrofit annotations (`@POST`, `@GET`, `@PUT`, `@DELETE`).
- Method signatures must return `Future<ApiResult<ResponseModel>>` or `Future<ApiResult<void>>`.

### Step 3: Domain Entities
Location: `lib/features/<feature>/domain/entity/`
- Define pure Dart domain models representing business concepts.
- Keep fields non-nullable with `required` constructor parameters.

### Step 4: Data Mappers
Location: `lib/features/<feature>/data/mapper/<feature>_mapper.dart`
- Each mapper is implemented as a concrete, non-abstract class annotated with `@injectable`.
- It contains **2 instance methods** (non-static):
  1. `toEntity(ModelDM? model)`: Converts a single Data Model (DTO) to a Domain Entity with safe default fallbacks for null model fields.
  2. `toEntityList(List<ModelDM>? models)`: Converts a nullable list of Data Models into a list of Domain Entities.

Example Pattern:
```dart
import 'package:injectable/injectable.dart';

@injectable
class <Feature>Mapper {
  <Entity> toEntity(<Feature>DM? model) {
    return <Entity>(
      id: model?.id ?? '',
      name: model?.name ?? '',
    );
  }

  List<<Entity>> toEntityList(List<<Feature>DM>? models) {
    return models?.map((e) => toEntity(e)).toList() ?? [];
  }
}
```

### Step 5: Remote Data Source
Location: `lib/features/<feature>/data/repository/data_sources/`
- Interface: `abstract class <Feature>RemoteDataSource` defining raw API calls returning `Future<ApiResult<T>>`.
- Implementation: `@Injectable(as: <Feature>RemoteDataSource)` `class <Feature>RemoteDataSourceImpl`:
  - Injects `ApiServices`.
  - Wraps API calls with `handleDioError` inside `try-catch`.

### Step 6: Domain & Data Repository
- **Domain Contract**: `lib/features/<feature>/domain/repository/<feature>_repository.dart`
  - Define `abstract class <Feature>Repository` specifying business capabilities that return Domain Entities (`ApiResult<List<Entity>>`).
- **Data Implementation**: `lib/features/<feature>/data/repository/<feature>_repository_impl.dart`
  - Annotate with `@Injectable(as: <Feature>Repository)`.
  - Injects `<Feature>RemoteDataSource` and `<Feature>Mapper`.
  - Implements `<Feature>Repository`, invoking `<Feature>RemoteDataSource` and using injected `<Feature>Mapper` instance methods to map Data Models into Domain Entities before returning `ApiResult`.

### Step 7: Domain UseCase(s)
Location: `lib/features/<feature>/domain/usecase/`
- Single-responsibility class annotated with `@injectable`.
- Exposes a `call()` method that delegates business calls to the domain repository interface:
  ```dart
  @injectable
  class <UseCaseName>UseCase {
    final <Feature>Repository _repository;
    <UseCaseName>UseCase(this._repository);

    Future<ApiResult<T>> call(Params params) => _repository.someMethod(params);
  }
  ```

### Step 8: Cubit State & Cubit Controller
Location: `lib/features/<feature>/ui/screens/<screen_name>/cubit/`
- **State**: `<Screen>State` wrapping data states using `Resource<T>` (`initial`, `loading`, `success`, `error`).
- **Cubit**: `@injectable` `class <Screen>Cubit extends Cubit<<Screen>State>`:
  - Inject required UseCases.
  - Execute UseCases and emit updated states.

### Step 9: Screen UI Implementation
Location: `lib/features/<feature>/ui/screens/<screen_name>/<screen_name>_screen.dart`
- Build Flutter UI (`StatelessWidget` or `StatefulWidget`).
- Re-use common UI components in `lib/features/common/widgets/` (`AppButton`, `AppTextField`, etc.) and colors from `AppColors` (`lib/core/theme/colors.dart`).
- Wire Cubit using `BlocBuilder` and `BlocListener` for handling side-effects (e.g., snackbars, navigation).

### Step 10: App Router Registration
Location: `lib/core/routes/app_router.dart`
- Register route name constant and route builder case inside `AppRouter` (`abstract final class`).

### Step 11: Code Generation & Verification
Run `build_runner` to generate dependency injection bindings and Retrofit service implementations:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
Run static analysis and debug build verification:
```bash
flutter analyze
flutter build apk --debug
```

---

## 🛑 Important Rules & Conventions

1. **Colors**: Always reference `AppColors` (`lib/core/theme/colors.dart`). Never hardcode hex color values in UI files.
2. **Themes**: Defined in `AppTheme` (`lib/core/theme/app_theme.dart`).
3. **Mappers**: Always create concrete `@injectable` mapper classes in `data/mapper/` with instance methods (`toEntity` and `toEntityList`). Do NOT use abstract classes or static methods for mappers.
4. **Domain Entities**: Domain entities returned by repositories must have non-nullable fields.
5. **Dependency Injection**: Use `@Injectable(as: AbstractInterface)` for repository & data source implementations, and `@injectable` for mappers, UseCases, and Cubits.
6. **Error Handling**: API errors must be wrapped via `handleDioError` returning `ApiResult`.
