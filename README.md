# Random Image App - Flutter

A Flutter mobile application that fetches random images with adaptive backgrounds using Clean Architecture and BLoC pattern.

## 📱 Demo Video

[Watch Demo Video](./demo-video.mp4)


## ✨ Features

-  **Adaptive Background Colors** - Extracts dominant color from images
-  **Smooth Transitions** - 700ms color animations
-  **Dynamic Theming** - Button adapts to background brightness
-  **Clean Architecture** - Separation of concerns with layers
-  **BLoC Pattern** - State management
-  **Dio HTTP Client** - API calls with error handling
-  **Dependency Injection** - GetIt for DI
-  **Error Handling** - Graceful error states

## 🏗️ Architecture
```
lib/
├── core/                   # Core utilities
│   ├── constants/          # API URLs
│   ├── error/              # Failure classes
│   └── usecases/           # Base use case
├── data/                   # Data layer
│   ├── datasources/        # Remote data sources
│   ├── models/             # Data models
│   └── repositories/       # Repository implementations
├── domain/                 # Business logic layer
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository contracts
│   └── usecases/           # Business use cases
├── presentation/           # UI layer
│   ├── bloc/               # BLoC state management
│   ├── common_cubit/       # Shared state management
│   └── pages/              # UI screens
├── injection_container.dart # Dependency injection
└── main.dart               # App entry point
```

## 📦 Dependencies
```yaml
dependencies:
  flutter_bloc: ^8.1.3      # State management
  get_it: ^7.6.4            # Dependency injection
  dio: ^5.3.3               # HTTP client
  dartz: ^0.10.1            # Functional programming
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/random-image-app-flutter.git
cd random-image-app-flutter
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
# For Android
flutter run

# For iOS
flutter run -d ios
```

## 🔧 Configuration

The app uses the following API endpoint:
```dart
// lib/core/constants/api_constants.dart
static const String baseUrl = 'https://november7-730026606190.europe-west1.run.app';
static const String imageEndpoint = '/image';
```

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (iOS 11+)

## 🧪 Testing

Run tests:
```bash
flutter test
```

## 🏛️ Clean Architecture Layers

### 1. **Presentation Layer**
- UI components (Widgets)
- BLoC for state management
- User interaction handling

### 2. **Domain Layer**
- Business entities
- Use cases (business logic)
- Repository interfaces

### 3. **Data Layer**
- Repository implementations
- Data sources (Remote API)
- Data models

## 🎯 Technical Highlights

- **BLoC Pattern**: Predictable state management
- **Dependency Injection**: GetIt for loose coupling
- **Error Handling**: Either type with Dartz
- **Color Extraction**: Canvas API for dominant colors
- **Smooth Animations**: AnimationController with Color.lerp
- **Network Caching**: Automatic image caching

## 📝 API Response Format
```json
{
  "url": "https://images.unsplash.com/photo-1506744038136-46273834b3fb"
}
```

---

**Built with ❤️ using Flutter**