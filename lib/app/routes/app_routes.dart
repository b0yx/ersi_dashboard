part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const CREATE_PROJECT = _Paths.CREATE_PROJECT;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const CREATE_PROJECT = '/create-project';
}
