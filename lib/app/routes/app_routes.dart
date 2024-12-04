part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const CREATE_PROJECT = _Paths.CREATE_PROJECT;
  static const INSPECTION_TYPES = _Paths.INSPECTION_TYPES;
  static const ARCHITECTURAL_INSPECTION = _Paths.ARCHITECTURAL_INSPECTION;
  static const STRUCTURAL_INSPECTION = _Paths.STRUCTURAL_INSPECTION;
  static const GEOTECHNICAL_INSPECTION = _Paths.GEOTECHNICAL_INSPECTION;
  static const MECHANICAL_INSPECTION = _Paths.MECHANICAL_INSPECTION;
  static const ELECTRICAL_INSPECTION = _Paths.ELECTRICAL_INSPECTION;
  static const SURVEY_WORKS = _Paths.SURVEY_WORKS;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const CREATE_PROJECT = '/create-project';
  static const INSPECTION_TYPES = '/inspection-types';
  static const ARCHITECTURAL_INSPECTION = '/architectural-inspection';
  static const STRUCTURAL_INSPECTION = '/structural-inspection';
  static const GEOTECHNICAL_INSPECTION = '/geotechnical-inspection';
  static const MECHANICAL_INSPECTION = '/mechanical-inspection';
  static const ELECTRICAL_INSPECTION = '/electrical-inspection';
  static const SURVEY_WORKS = '/survey-works';
}
