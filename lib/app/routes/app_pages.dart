import 'package:ersei/app/modules/home/views/home_view.dart';
import 'package:ersei/app/modules/home/views/create_project_view.dart';
import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/bindings/create_project_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PROJECT,
      page: () => const CreateProjectView(),
      binding: CreateProjectBinding(),
    ),
  ];
}
