# Pokedex

A flutter technical challenge made with ❤️ for MOONSHOT. The purpose of the challenge was consuming the https://pokeapi.co/ and show a paginated list of Pokemons and the details when these are clicked

## Project Architecture

```yml
lib
├── core
│   ├── constants
│   │   ├── colors.dart
│   │   ├── fonts.dart
│   │   ├── sizes.dart
│   │   ├── styles.dart
│   │   ├── theme.dart
│   │   └── urls.dart
│   ├── l10n
│   ├── observables
│   ├── http_client
│   └── routing
├── features
│   └── feature
│       ├── data
│       │   ├── datasources # data transfer objects - data comming from external sources
│       │   │   ├── remote_data_source.dart
│       │   │   └── local_data_source.dart
│       │   ├── models # data transfer objects - data comming from external sources
│       │   │   └── feature_model.dart
│       │   ├── repositories # different repositories implementations
│       │   │   ├── feature_repository_impl.dart
│       │   │   └── fake_repository_impl.dart
│       ├── domain
│       │   ├── entities # the feature data model used by the pages/widgets
│       │   │   └── feature.dart
│       │   ├── providers # uses_cases and repositories providers
│       │   │   ├── get_feature_provider.dart
│       │   │   └── feature_repository_provider.dart
│       │   ├── repositories # respository abstract contracts
│       │   │   └── feature_repository.dart
│       │   └── use_cases # get the feature data model from one or several dtos
│       │       ├── save_feature.dart
│       │       └── get_feature.dart
│       ├── exceptions # feature level exceptions
│       │   └── some_exception.dart 
│       ├── presentation
│       │   ├── providers # provider state managment solution
│       │   │   ├── state
│       │   │   │   ├── feature_notifier.dart # providers notifiers
│       │   │   │   └── feature_state.dart # provider states
│       │       └── providers.dart 
│       │   ├── screens # the feature screens
│       │   │   ├── feature_screen.dart
│       │   │   ├── feature_desktop.dart # desktop view of feature_screen.dart
│       │   │   ├── feature_mobile.dart # mobile view of feature_screen.dart
│       │   │   └── feature_tablet.dart # tablet view of feature_screen.dart
│       │   └── widgets # specific components of the feature
│       │       └── some_widget.dart
│       └── _index_.dart # barrel file
├── shared # common components
│    ├── utils
│    │   ├── colorized.dart
│    │   ├── crypto.dart
│    │   ├── dialogs.dart
│    │   └── validator.dart
│    ├── image_manager # complex common features which can be divided in layers
│    │   ├── data 
│    │   ├── domain
│    │   └── presentation
│    └── widgets
└── main.dart
```

## Call flow

![Claen Arch](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?w=556&ssl=1)

*Credits: https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure*

 

>### Important: not all the features will have all the layers

## Getting started

1. Install Flutter following https://docs.flutter.dev/get-started/install.
2. Check if you are all set:

    ```cmd
    flutter doctor
    ```
3. Install dependencies

    ```cmd
    flutter pub get
    ```
4. Open an Android or iOS emulator
5. Onces is opened, list the devices on flutter scope
    ```cmd
    flutter devices
    ```

4. Run de project targeting the device name (2nd column), usually Android emulators ends with (emulator) and iPhone simulators ends with (simulator)

    ```cmd
    flutter pub run -d <device_name>
    ```

## Features

- Infinite list of pokemons fetched from https://pokeapi.co/api/v2/pokemon.
- Pokemon details screen.
- State managment with [Riverpod](https://riverpod.dev/).
- Use [Hive](https://docs.hivedb.dev/#/README) for saving data and images on local store.
- CI/CD with GitHub Actions 
- Live preview autodeployment.
- Pokemon List works offline, still working on Pokemon Details.

## Supported platforms

- Android (locally)
- iOS (locally)
- web (under development)

## Screenshots

| ![Screenshot_1691511609](https://github.com/EugenioTesio/pokedex/assets/5660624/7924d1cd-6762-4126-abf5-c734a718fd05) | ![Simulator Screenshot - iPhone 14 - 2023-08-08 at 13 16 56](https://github.com/EugenioTesio/pokedex/assets/5660624/6a8be120-8418-4aaf-85d0-64c2eb971b57) | ![Simulator Screenshot - iPhone 14 - 2023-08-08 at 13 17 04](https://github.com/EugenioTesio/pokedex/assets/5660624/b183f817-89d5-40a1-97d4-b14d3319c0b0) |
| - | - | - |
| ![Simulator Screenshot - iPhone 14 - 2023-08-08 at 13 17 14](https://github.com/EugenioTesio/pokedex/assets/5660624/2fd31179-b3f7-4af7-a92d-909e842296f7) | ![Simulator Screenshot - iPhone 14 - 2023-08-08 at 13 17 20](https://github.com/EugenioTesio/pokedex/assets/5660624/419ab232-5108-4e40-b41c-9d72b83f0e2c) | ![Simulator Screenshot - iPhone 14 - 2023-08-08 at 13 17 26](https://github.com/EugenioTesio/pokedex/assets/5660624/cb6c8896-dd00-4262-9af0-9dc415fe4c2c) |

## Live preview

[https://pokedex-676eb.web.app/](https://pokedex-676eb.web.app)