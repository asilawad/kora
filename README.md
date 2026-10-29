# Kora

Kora is a Flutter client for the Dori court-booking API. It supports Arabic and English, with Arabic as the default locale.

## Features

- Public home and service browsing
- Service availability, courts, and time-slot selection
- Sign-in and registration when authentication is required
- Booking creation and upcoming/past booking management
- Booking cancellation using eligibility supplied by the API

## Architecture

Feature-first Clean Architecture separates presentation, domain, and data:

```text
Presentation (pages, widgets, cubits)
                 ↓
Domain (entities, repositories, use cases)
                 ↑
Data (models, remote sources, repository implementations)
                 ↓
             Dori API
```

Shared networking, localization, errors, routing, storage, and theme live in `lib/core/`.

## Stack

- Flutter and Dart
- `flutter_bloc` for presentation state
- `go_router` for navigation and the indexed bottom-navigation shell
- `dio` for HTTP and `get_it` for dependency injection
- `flutter_secure_storage` for authentication tokens
- Flutter localization with ARB files for Arabic and English

## Run

Install dependencies and run the app on a configured Flutter device:

```shell
flutter pub get
flutter run
```

Run the test suite with:

```shell
flutter test
```

## API configuration

The API base URL is `https://dori.toldpath.com/api/v1`; the place slug is `kora`. Both are defined in `lib/core/constants/api_constants.dart`.

## Folder structure

```text
lib/
  core/                 Shared app infrastructure and design system
  features/
    app_shell/          Persistent home and bookings navigation
    auth/               Authentication
    booking/            Booking creation
    home/               Place and featured services
    my_bookings/        Upcoming/past bookings and cancellation
    services/           Search and service catalogue
    service_details/    Availability and service presentation
test/
  core/                 Shared component tests
  features/             Feature tests and fixture-backed API model tests
```

## Design decisions

- Home and service browsing are public; authentication is requested only for protected actions.
- Recoverable network failures are shown inline with retry actions.
- The app does not add a Flutter-native splash screen.
- Slot times are displayed as returned by the API, without device-timezone conversion.
- Booking and cancellation rules, status labels, and cancellation eligibility come from the API.

## Known limitations

- Payment is currently cash at the venue.
- Booking rescheduling and reviews are not implemented.
- The client targets the configured Dori place rather than supporting place selection.
