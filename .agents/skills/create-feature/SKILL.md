---
name: create-feature
description: >-
  Creates a new feature in this Flutter application adhering to the codebase's
  Feature-First Clean Architecture pattern, including Retrofit API calls, Injectable GetIt DI,
  AppRouter navigation, Cubit state management with Resource, Data Mappers, and AppTheme/AppColors styling.
---

# Create Feature Skill

This skill guides the implementation of new end-to-end features in this Flutter project, following the established **Feature-First Clean Architecture**, **Retrofit** networking, **Data Mappers**, **Injectable + GetIt** dependency injection, **Cubit** state management, **AppRouter** routing, and **AppTheme / AppColors** design system.

---

## 🏛️ System Architecture Overview

Each feature resides in `lib/features/<feature_name>/` and follows strict layer separation:

```text
lib/
├── core/
│   ├── di/                 # GetIt & Injectable setup
│   ├── routes/             # AppRouter (abstract final class)
│   └── theme/              # AppColors & AppTheme
│
├── features/
│   ├── common/             # Reusable UI widgets & Resource state wrapper
│   ├── network/            # Retrofit ApiServices, ApiResult, Request/Response DTOs
│   │
│   └── <feature_name>/     # e.g., auth, commerce, products, cart
│       ├── data/
│       │   ├── mappers/                # Data Mappers (<Entity>Mapper transform <Entity>DM to <Entity>)
│       │   └── repository/
│       │       ├── data_sources/       # <Feature>RemoteDataSource & <Feature>RemoteDataSourceImpl
│       │       └── <feature>_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entity/                 # Pure Dart Domain Entities (non-nullable fields)
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

## 📋 Step-by-Step Feature Implementation Guide

When creating a new feature (e.g. `<feature>` with a screen `<screen>`), follow these steps sequentially:

### Step 1: Network DTOs & Endpoint (`lib/features/network/`)

1. **Request DTO** (if applicable):
   File: `lib/features/network/model/request/<request_name>_request.dart`
   ```dart
   class <RequestName>Request {
     final String param;

     <RequestName>Request({required this.param});

     Map<String, dynamic> toJson() => {
       'param': param,
     };
   }
   ```

2. **Response DTO**:
   File: `lib/features/network/model/response/<response_name>_response.dart`
   ```dart
   class <ResponseName>Response {
     final List<<Entity>DM>? data;

     <ResponseName>Response({this.data});

     factory <ResponseName>Response.fromJson(Map<String, dynamic> json) {
       return <ResponseName>Response(
         data: json['data'] != null
             ? (json['data'] as List).map((v) => <Entity>DM.fromJson(v)).toList()
             : null,
       );
     }
   }
   ```

3. **Retrofit API Service**:
   File: `lib/features/network/api/api_services.dart`
   Add the HTTP endpoint to `ApiServices`:
   ```dart
   @GET('path/to/endpoint')
   Future<<ResponseName>Response> <methodName>();
   ```

---

### Step 2: Domain Entity (`lib/features/<feature>/domain/entity/`)

Create non-nullable pure Dart domain entity model:
File: `lib/features/<feature>/domain/entity/<entity>.dart`
```dart
class <Entity> {
  final String id;
  final String title;
  final num price;

  const <Entity>({
    required this.id,
    required this.title,
    required this.price,
  });
}
```

---

### Step 3: Data Mapper (`lib/features/<feature>/data/mappers/`)

Create `@injectable` Data Mapper transforming Data Models (`<Entity>DM`) to non-nullable Domain Entities (`<Entity>`) with safe default fallbacks:
File: `lib/features/<feature>/data/mappers/<entity>_mapper.dart`
```dart
import 'package:injectable/injectable.dart';
import 'package:ecommerce_c19/features/<feature>/domain/entity/<entity>.dart';
import 'package:ecommerce_c19/features/network/model/response/<entity>_dm.dart';

@injectable
class <Entity>Mapper {
  <Entity> toEntity(<Entity>DM dm) => <Entity>(
        id: dm.id ?? "",
        title: dm.title ?? "",
        price: dm.price ?? 0,
      );

  List<<Entity>> toEntities(List<<Entity>DM> dms) =>
      dms.map(toEntity).toList();
}
```

---

### Step 4: Remote Data Source (`lib/features/<feature>/data/repository/data_sources/`)

1. **Contract**:
   File: `lib/features/<feature>/data/repository/data_sources/<feature>_remote_data_source.dart`
   ```dart
   import 'package:ecommerce_c19/features/network/api_result.dart';
   import 'package:ecommerce_c19/features/network/model/response/<response_name>_response.dart';

   abstract class <Feature>RemoteDataSource {
     Future<ApiResult<<ResponseName>Response>> <methodName>();
   }
   ```

2. **Implementation**:
   File: `lib/features/<feature>/data/repository/data_sources/<feature>_remote_data_source_impl.dart`
   ```dart
   import 'package:dio/dio.dart';
   import 'package:injectable/injectable.dart';
   import 'package:ecommerce_c19/features/network/api/api_services.dart';
   import 'package:ecommerce_c19/features/network/api_result.dart';
   import 'package:ecommerce_c19/features/network/utils/handle_dio_error.dart';
   import 'package:<feature>_remote_data_source.dart';

   @Injectable(as: <Feature>RemoteDataSource)
   class <Feature>RemoteDataSourceImpl extends <Feature>RemoteDataSource {
     final ApiServices _apiServices;

     <Feature>RemoteDataSourceImpl(this._apiServices);

     @override
     Future<ApiResult<<ResponseName>Response>> <methodName>() async {
       try {
         var response = await _apiServices.<methodName>();
         return SuccessApiResult(data: response);
       } on DioException catch (e) {
         return handleDioError<<ResponseName>Response>(e);
       } catch (e) {
         return FailureApiResult(ServerError());
       }
     }
   }
   ```

---

### Step 5: Domain & Data Repository

1. **Domain Repository Contract**:
   File: `lib/features/<feature>/domain/repository/<feature>_repository.dart`
   ```dart
   import 'package:ecommerce_c19/features/<feature>/domain/entity/<entity>.dart';
   import 'package:ecommerce_c19/features/network/api_result.dart';

   abstract class <Feature>Repository {
     Future<ApiResult<List<<Entity>>>> <methodName>();
   }
   ```

2. **Data Repository Implementation**:
   File: `lib/features/<feature>/data/repository/<feature>_repository_impl.dart`
   ```dart
   import 'package:injectable/injectable.dart';
   import 'package:ecommerce_c19/features/<feature>/data/mappers/<entity>_mapper.dart';
   import 'package:ecommerce_c19/features/<feature>/data/repository/data_sources/<feature>_remote_data_source.dart';
   import 'package:ecommerce_c19/features/<feature>/domain/entity/<entity>.dart';
   import 'package:ecommerce_c19/features/<feature>/domain/repository/<feature>_repository.dart';
   import 'package:ecommerce_c19/features/network/api_result.dart';

   @Injectable(as: <Feature>Repository)
   class <Feature>RepositoryImpl extends <Feature>Repository {
     final <Feature>RemoteDataSource _remoteDataSource;
     final <Entity>Mapper _mapper;

     <Feature>RepositoryImpl(this._remoteDataSource, this._mapper);

     @override
     Future<ApiResult<List<<Entity>>>> <methodName>() async {
       var apiResult = await _remoteDataSource.<methodName>();
       if (apiResult.isSuccess && apiResult.getData()?.data != null) {
         final entities = _mapper.toEntities(apiResult.getData()!.data!);
         return SuccessApiResult(data: entities);
       }
       return FailureApiResult(apiResult.getException());
     }
   }
   ```

---

### Step 6: Domain UseCase (`lib/features/<feature>/domain/usecase/`)

File: `lib/features/<feature>/domain/usecase/<usecase_name>_usecase.dart`
```dart
import 'package:injectable/injectable.dart';
import 'package:ecommerce_c19/features/<feature>/domain/entity/<entity>.dart';
import 'package:ecommerce_c19/features/<feature>/domain/repository/<feature>_repository.dart';
import 'package:ecommerce_c19/features/network/api_result.dart';

@injectable
class <UseCaseName>UseCase {
  final <Feature>Repository _repository;

  <UseCaseName>UseCase(this._repository);

  Future<ApiResult<List<<Entity>>>> call() {
    return _repository.<methodName>();
  }
}
```

---

### Step 7: Presentation State & Cubit (`lib/features/<feature>/ui/screens/<screen>/cubit/`)

1. **State**:
   File: `lib/features/<feature>/ui/screens/<screen>/cubit/<screen>_state.dart`
   ```dart
   import 'package:ecommerce_c19/features/common/utils/resource.dart';
   import 'package:ecommerce_c19/features/<feature>/domain/entity/<entity>.dart';

   class <Screen>State {
     Resource<List<<Entity>>> <action>Api = Resource.initial();

     <Screen>State({required this.<action>Api});
   }
   ```

2. **Cubit**:
   File: `lib/features/<feature>/ui/screens/<screen>/cubit/<screen>_cubit.dart`
   ```dart
   import 'package:flutter_bloc/flutter_bloc.dart';
   import 'package:injectable/injectable.dart';
   import 'package:ecommerce_c19/features/common/utils/resource.dart';
   import 'package:ecommerce_c19/features/<feature>/domain/usecase/<usecase_name>_usecase.dart';
   import 'package:ecommerce_c19/features/<feature>/ui/screens/<screen>/cubit/<screen>_state.dart';

   @injectable
   class <Screen>Cubit extends Cubit<<Screen>State> {
     final <UseCaseName>UseCase _useCase;

     <Screen>Cubit(this._useCase) : super(<Screen>State(<action>Api: Resource.initial()));

     Future<void> perform<Action>() async {
       emit(<Screen>State(<action>Api: Resource.loading()));
       var result = await _useCase.call();
       if (result.isSuccess) {
         emit(<Screen>State(<action>Api: Resource.success(data: result.getData())));
       } else {
         emit(<Screen>State(<action>Api: Resource.error(errorMessage: result.errorMessage)));
       }
     }
   }
   ```

---

### Step 8: Screen UI Widget (`lib/features/<feature>/ui/screens/<screen>/`)

File: `lib/features/<feature>/ui/screens/<screen>/<screen>_screen.dart`
Key UI & Styling Rules:
- Use `AppColors` from `lib/core/theme/colors.dart` (e.g. `AppColors.primary`, `AppColors.white`).
- Use `AppTheme` styles from `lib/core/theme/app_theme.dart`.
- Use shared components from `lib/features/common/widgets/` (`AppButton`, `AppTextField`).
- Wrap with `BlocProvider` using `getIt<<Screen>Cubit>()`.
- Use `BlocConsumer` or `BlocListener` to react to `Resource` state changes.

---

### Step 9: App Router (`lib/core/routes/app_router.dart`)

Add static route getter to `AppRouter`:
```dart
abstract final class AppRouter {
  // Existing routes...
  static MaterialPageRoute get <screenName> =>
      MaterialPageRoute(builder: (_) => const <Screen>Screen());
}
```

---

### Step 10: Code Generation & Dependency Injection Verification

After creating/modifying injectable classes, mappers, or Retrofit services, execute:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Then verify static analysis with:
```bash
flutter analyze
```

---

## 🎨 Summary of Core Project Conventions

1. **Colors**: Always use `AppColors` defined in `lib/core/theme/colors.dart`.
2. **Themes**: Always use `AppTheme` defined in `lib/core/theme/app_theme.dart`.
3. **Domain Entities**: Fields in domain entities (`lib/features/<feature>/domain/entity/`) must be non-nullable (`required`).
4. **Data Mappers**: Data mappers (`lib/features/<feature>/data/mappers/<entity>_mapper.dart`) must be annotated with `@injectable` and handle null safety with fallback defaults (`??`).
5. **DI Annotations**:
   - Mappers, UseCases, Cubits: `@injectable`
   - Data Sources & Repositories: `@Injectable(as: AbstractInterface)`
6. **Network Result**: Data sources and repositories return `ApiResult<T>`, wrapped using `handleDioError`.
7. **State Representation**: Cubit states wrap asynchronous operations inside `Resource<T>` (`initial`, `loading`, `success`, `error`).
