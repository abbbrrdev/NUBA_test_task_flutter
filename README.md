# Movies App

Flutter app using Clean Architecture, BLoC, and Dio to browse TMDB popular movies, search by title, and view details.

## Stack

- Clean Architecture: `features/movies/` split into `data/`, `domain/`, `presentation/`
- State management: `flutter_bloc`
- Networking: `dio` with `pretty_dio_logger`
- DI: `get_it`
- Env: `flutter_dotenv`

## Setup

1. Create `.env` in the project root and set your TMDB v4 API token (DO NOT prefix with `Bearer`, the app adds it):

```
TMDB_TOKEN=YOUR_TMDB_V4_TOKEN
```

You can copy from `.env.example`.

2. Fetch dependencies:

```
flutter pub get
```

3. Run the app:

```
flutter run
```

## Project Structure

- `lib/core/`
  - `constants.dart`
  - `di/injection.dart`
  - `network/dio_client.dart`
  - `error/`
- `lib/features/movies/`
  - `data/` (DTOs, API, repository impl)
  - `domain/` (entities, repositories, use cases)
  - `presentation/` (BLoC/Cubits, pages, widgets)

## Features

- Popular movies list with poster, title, rating
- Search movies by title
- Movie details with description, release date, genres
- Pull-to-refresh on list

## Notes

- API base: https://api.themoviedb.org/3
- Images base: https://image.tmdb.org/t/p/w500
