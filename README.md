# Eunhyo iOS

Flutter-based iPhone/iPad migration of the Android app in `sofajohnlee/eunhyo`.

## Migration approach

The Android project contains many Activities and XML layouts. This project groups them by user-facing feature instead of making a 1:1 Activity-to-page translation.

Initial feature areas:

- Home
- Elementary school / math
- English
- Korean
- Hanja
- Drawing
- Games
- Sports / video
- AI
- Registry procedure assistant
- Score storage

## Local setup

After cloning this repository, run:

```bash
flutter create .
flutter pub get
flutter analyze
flutter run
```

`flutter create .` generates the platform-specific iOS/Android runner files that should not be hand-maintained in this migration repository.

## Android source

The Android reference project is `sofajohnlee/eunhyo`.

The migration is being implemented incrementally so that existing functionality is not silently discarded.
