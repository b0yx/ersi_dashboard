import 'package:ersei/app/modules/home/bindings/auth/login_binding.dart';
import 'package:ersei/app/modules/home/bindings/auth/newpassword_binding.dart';
import 'package:ersei/app/modules/home/bindings/auth/resetpassword_binding.dart';
import 'package:ersei/app/modules/home/bindings/auth/verificationcode_binding.dart';
import 'package:ersei/app/modules/home/views/auth/new_password_view.dart';
import 'package:ersei/app/modules/home/views/auth/reset_password_view.dart';
import 'package:ersei/app/modules/home/views/auth/signup_view.dart';
import 'package:ersei/app/modules/home/views/auth/verification_code_view.dart';
import 'package:ersei/app/modules/home/views/screen/home_view.dart';
import 'package:ersei/app/modules/home/views/screen/create_project_view.dart';
import 'package:ersei/app/modules/home/views/screen/inspection_types_view.dart';
import 'package:ersei/app/modules/home/views/screen/architectural_inspection_view.dart';
import 'package:ersei/app/modules/home/views/screen/structural_inspection_view.dart';
import 'package:ersei/app/modules/home/views/screen/geotechnical_inspection_view.dart';
import 'package:ersei/app/modules/home/views/screen/mechanical_inspection_view.dart';
import 'package:ersei/app/modules/home/views/screen/electrical_inspection_view.dart';
import 'package:ersei/app/modules/home/views/screen/survey_works_view.dart';
import 'package:ersei/app/modules/home/views/screen/report_success_view.dart';
import 'package:ersei/app/modules/home/views/screen/wellcome_view.dart';
import 'package:get/get.dart';
import '../modules/home/bindings/auth/signup_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/bindings/create_project_binding.dart';
import '../modules/home/bindings/inspection_types_binding.dart';
import '../modules/home/bindings/architectural_inspection_binding.dart';
import '../modules/home/bindings/structural_inspection_binding.dart';
import '../modules/home/bindings/geotechnical_inspection_binding.dart';
import '../modules/home/bindings/mechanical_inspection_binding.dart';
import '../modules/home/bindings/electrical_inspection_binding.dart';
import '../modules/home/bindings/survey_works_binding.dart';
import '../modules/home/bindings/report_success_binding.dart';
import '../modules/home/bindings/wellcome_binding.dart';
import '../modules/home/views/auth/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [

    //AUTH
    GetPage(
      name: _Paths.LOGINVIEW,
      page: () =>   LoginView(),
      binding: LoginViewBindings(),
    ),
    GetPage(
      name: _Paths.SIGNUPVIEW,
      page: () =>   SignupView(),
      binding: SignBindings(),
    ),
    GetPage(
      name: _Paths.RESETPASSWORD,
      page: () =>  const ResetPasswordView(),
      binding: ResetPasswordBindings(),
    ),
    GetPage(
      name: _Paths.VERIFICATIONCODEVIEW,
      page: () =>  const VerificationCodeView(),
      binding: VerificationCodeBinding(),
    ),
    GetPage(
      name: _Paths.NEWPASSWORD,
      page: () =>  const NewPasswordView(),
      binding: NewPasswordBindings(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WELLCOME_VIEW,
      page: () =>   WellcomeView(),
      binding: WellcomeViewBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PROJECT,
      page: () => const CreateProjectView(),
      binding: CreateProjectBinding(),
    ),
    GetPage(
      name: _Paths.INSPECTION_TYPES,
      page: () => const InspectionTypesView(),
      binding: InspectionTypesBinding(),
    ),
    GetPage(
      name: _Paths.ARCHITECTURAL_INSPECTION,
      page: () => const ArchitecturalInspectionView(),
      binding: ArchitecturalInspectionBinding(),
    ),
    GetPage(
      name: _Paths.STRUCTURAL_INSPECTION,
      page: () => const StructuralInspectionView(),
      binding: StructuralInspectionBinding(),
    ),
    GetPage(
      name: _Paths.GEOTECHNICAL_INSPECTION,
      page: () => const GeotechnicalInspectionView(),
      binding: GeotechnicalInspectionBinding(),
    ),
    GetPage(
      name: Routes.MECHANICAL_INSPECTION,
      page: () => const MechanicalInspectionView(),
      binding: MechanicalInspectionBinding(),
    ),
    GetPage(
      name: Routes.ELECTRICAL_INSPECTION,
      page: () => const ElectricalInspectionView(),
      binding: ElectricalInspectionBinding(),
    ),
    GetPage(
      name: Routes.SURVEY_WORKS,
      page: () => const SurveyWorksView(),
      binding: SurveyWorksBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_SUCCESS,
      page: () => const ReportSuccessView(),
      binding: ReportSuccessBinding(),
    ),
  ];
}
