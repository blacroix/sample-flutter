# Sample

Sample project to experiment those libraries:
* [auto_route](https://pub.dev/packages/auto_route)
* [injectable](https://pub.dev/packages/injectable)
  * [get_it](https://pub.dev/packages/get_it)
* [retrofit](https://pub.dev/packages/retrofit)
  * [dio](https://pub.dev/packages/dio)
* [flutter_bloc](https://pub.dev/packages/flutter_bloc)

See [pubspec.yaml](./pubspec.yaml) for more.

Sample is designed following hexagonal architecture principles:
* Data contains the repositories to communicate with the IS
* Domain contains the functional logic of the app
  * Domain is independent of other layers
* Presentation contains the UI part of the app
  * Presentation layer uses Bloc as state management

## Getting Started

Sample uses code generation, prior to build the app code generation should be done:

```shell
flutter pub run build_runner watch
```