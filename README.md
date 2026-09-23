# 🛒 E-Commerce App (ecommerce_c19)

A feature-rich, production-ready E-Commerce mobile application built with **Flutter** using **Feature-First Clean Architecture**, **BLoC / Cubit** for state management, **Retrofit & Dio** for network communication, and **Injectable + GetIt** for dependency injection.

---

## 📱 Features

- 🔐 **Authentication & Authorization**
  - User registration and login.
  - Persistent authentication state using encrypted local storage (`SharedPreferences`).
  - Automatic session restore on app launch.

- 🛍️ **Store & Catalog Browsing**
  - **Home Screen**: Dynamic promotional banners, categories carousel, brand highlights, and featured product listings.
  - **Categories Screen**: Categorized product explorer with sub-category tabs.
  - **Products Screen**: Filtered grid of products with real-time rating and price tags.
  - **Product Details Screen**:
    - Multi-image swipeable carousel with page indicators and wishlist toggle.
    - Product metadata (sold count, average rating, formatted pricing).
    - Expandable description text ("Read More").
    - Color and size selection.
    - Quantity selector synchronized with Cart state.

- 🛒 **Cart Management**
  - Real-time cart state with network synchronization.
  - Increment / decrement product quantities with instant subtotal and total recalculations.
  - Remove items from cart.
  - In-flight request locking to prevent duplicate operations.
  - Empty cart handling and animated state updates.
  - Seamless checkout navigation flow.

- 👤 **Profile & Wishlist**
  - Wishlist management.
  - User profile details and settings.

---

## 🏛️ Architecture & Project Structure

The project strictly follows **Feature-First Clean Architecture** with clear separation of concerns across layers:

```text
lib/
├── core/
│   ├── di/                       # Dependency Injection setup (GetIt & Injectable)
│   ├── routes/                   # AppRouter centralized navigation
│   ├── shared_pref_utils/        # Local storage & Token management
│   ├── theme/                    # AppTheme, Typography, and AppColors
│   └── widgets/                  # Global shared UI components
│
├── features/
│   ├── auth/                     # Authentication feature (Login, Register)
│   ├── cart/                     # Cart feature (CartScreen, CartCubit, CartRepository)
│   │   ├── data/                 # Cart Mappers, Data Sources & Repository Implementation
│   │   ├── domain/               # Cart Pure Entities & Repository Interface
│   │   └── ui/                   # CartScreen & CartCubit
│   │
│   ├── commerce/                 # Commerce feature (Home, Categories, Products, Details)
│   │   ├── data/                 # Data Mappers & Data Sources
│   │   ├── domain/               # Domain Entities & Use Cases
│   │   └── ui/                   # MainTabsScreen, ProductsScreen, ProductDetailsScreen
│   │
│   ├── common/                   # Shared common widgets (QtyControlWidget, RouteLogo) & Resource wrapper
│   └── network/                  # Retrofit ApiServices, Dio client, Interceptors, DTOs & Error handling
│
└── main.dart                     # App entrypoint & global providers
```

### Layer Breakdown:
1. **Domain Layer**: Contains pure Dart entities, repository contracts, and single-responsibility use cases. Independent of any framework or external library.
2. **Data Layer**: Contains API models (DTOs), Data Mappers (`EntityMapper`), and Repository implementations managing remote/local data sources.
3. **Presentation (UI) Layer**: Utilizes Flutter widgets organized by screen, driven by Cubits (`flutter_bloc`) emitting immutable states encapsulated in `Resource<T>`.

---

## 🛠️ Tech Stack & Libraries

- **Framework**: [Flutter](https://flutter.dev) (Dart 3)
- **State Management**: [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) (Cubit)
- **Dependency Injection**: [`get_it`](https://pub.dev/packages/get_it) & [`injectable`](https://pub.dev/packages/injectable)
- **Networking & API**: [`dio`](https://pub.dev/packages/dio), [`retrofit`](https://pub.dev/packages/retrofit), and [`pretty_dio_logger`](https://pub.dev/packages/pretty_dio_logger)
- **Local Storage**: [`shared_preferences`](https://pub.dev/packages/shared_preferences)
- **Code Generation**: [`build_runner`](https://pub.dev/packages/build_runner), [`retrofit_generator`](https://pub.dev/packages/retrofit_generator), [`injectable_generator`](https://pub.dev/packages/injectable_generator)

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.12.0 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / Xcode (for running emulators or devices)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/A-hmed/ecommerce_c19.git
   cd ecommerce_c19
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run code generation**:
   Generate Injectable DI modules and Retrofit API services:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

---

## 🧪 Code Quality & Static Analysis

To run static analysis and ensure code formatting:
```bash
flutter analyze
```

---

## 📄 License

This project is created for educational and commercial demonstration purposes.
