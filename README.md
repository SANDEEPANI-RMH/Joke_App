# Flutter Joke App

A modern Flutter application that fetches and displays programming and Christmas-themed jokes. The app features a beautiful UI with animations, offline support, and automatic caching.

## Features

- Fetches programming and Christmas jokes from JokeAPI
- Elegant UI with smooth animations and transitions
- Offline support with local caching
- Pull-to-refresh functionality
- Error handling with fallback to cached jokes
- Modern design with gradient cards and custom shadows
- Responsive layout
- Auto-refresh mechanism (5-minute interval)

## Prerequisites

Before you begin, ensure you have installed:
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Git

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.0.0          # For HTTP requests
  shared_preferences: ^2.0.0  # For local storage
```

## Installation

1. Clone the repository:
```bash
git clone (https://github.com/SANDEEPANI-RMH/Joke_App.git)
cd flutter-joke-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart
├── joke.dart              # Joke model
├── joke_service.dart      # API and caching service
├── joke_list_page.dart    # Main UI page
└── app_theme.dart         # Theme configuration
```

## Architecture

- **Model**: The `Joke` class handles data modeling and JSON serialization
- **Service**: `JokeService` manages API calls and local caching
- **UI**: `JokeListPage` handles the presentation layer with animations
- **Theme**: `AppTheme` contains all styling constants and configurations

## Features In Detail

### Offline Support
- Jokes are automatically cached using SharedPreferences
- Cached jokes are displayed when offline
- Cache is updated every successful API call

### UI Components
- Custom gradient header with refresh button
- Animated joke cards with slide and fade effects
- Pull-to-refresh functionality
- Loading indicators
- Empty state handling
- Error state handling

### API Integration
- Uses JokeAPI (https://jokeapi.dev/)
- Fetches 5 jokes at a time
- Filters out NSFW, religious, and racist content
- Handles both single and two-part jokes

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details

## Acknowledgments

- [JokeAPI](https://jokeapi.dev/) for providing the joke data
- Flutter team for the amazing framework
- The open-source community for inspiration and support
