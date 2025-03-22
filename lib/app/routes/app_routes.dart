part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const WELLCOME_VIEW = _Paths.WELLCOME_VIEW;

  //AUTH
  static const LOGINVIEW =_Paths.LOGINVIEW;
  static const SIGNUPVIEW =_Paths.SIGNUPVIEW;
  static const RESETPASSWORD = _Paths.RESETPASSWORD;
  static const NEWPASSWORD = _Paths.NEWPASSWORD;
  static const VERIFICATIONCODEVIEW = _Paths.VERIFICATIONCODEVIEW;
  static const VERIFICATIONSIGNCODEVIEW=_Paths.VERIFICATIONSIGNCODEVIEW;


  static const CREATE_PROJECT = _Paths.CREATE_PROJECT;
  static const INSPECTION_TYPES = _Paths.INSPECTION_TYPES;
  static const ARCHITECTURAL_INSPECTION = _Paths.ARCHITECTURAL_INSPECTION;
  static const STRUCTURAL_INSPECTION = _Paths.STRUCTURAL_INSPECTION;
  static const GEOTECHNICAL_INSPECTION = _Paths.GEOTECHNICAL_INSPECTION;
  static const MECHANICAL_INSPECTION = _Paths.MECHANICAL_INSPECTION;
  static const ELECTRICAL_INSPECTION = _Paths.ELECTRICAL_INSPECTION;
  static const SURVEY_WORKS = _Paths.SURVEY_WORKS;
  // ignore: constant_identifier_names
  static const REPORT_SUCCESS = _Paths.REPORT_SUCCESS;

  //test
  static const TESTVIEW =_Paths.TESTVIEW;
  static const EXAMVIEW =_Paths.EXAMVIEW;

}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const WELLCOME_VIEW = '/wellcome_view';

  //AUTH
  static const LOGINVIEW = '/login_view';
  static const SIGNUPVIEW = '/signup_view';
  static const RESETPASSWORD = '/reset_password_view';
  static const NEWPASSWORD = '/new_password_view';
  static const VERIFICATIONCODEVIEW = '/verification_code_view';
  static const VERIFICATIONSIGNCODEVIEW ='/verification_code_signup_view';


  static const CREATE_PROJECT = '/create_project_view';
  static const INSPECTION_TYPES = '/inspection_types_view';
  static const ARCHITECTURAL_INSPECTION = '/architectural_inspection_view';
  static const STRUCTURAL_INSPECTION = '/structural_inspection_view';
  static const GEOTECHNICAL_INSPECTION = '/geotechnical_inspection_view';
  static const MECHANICAL_INSPECTION = '/mechanical_inspection_view';
  static const ELECTRICAL_INSPECTION = '/electrical_inspection_view';
  static const SURVEY_WORKS = '/survey_works_view';
  // ignore: constant_identifier_names
  static const REPORT_SUCCESS = '/report_success_view';

  //test
  static const TESTVIEW = '/test_view';
  static const EXAMVIEW = '/examnation_view';

}
