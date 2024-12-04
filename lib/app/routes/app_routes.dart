part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const CREATE_PROJECT = _Paths.CREATE_PROJECT;
  static const INSPECTION_TYPES = _Paths.INSPECTION_TYPES;
  static const ARCHITECTURAL_INSPECTION = _Paths.ARCHITECTURAL_INSPECTION;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const CREATE_PROJECT = '/create-project';
  static const INSPECTION_TYPES = '/inspection-types';
  static const ARCHITECTURAL_INSPECTION = '/architectural-inspection';
}
