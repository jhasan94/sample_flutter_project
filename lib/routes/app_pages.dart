import 'package:get/get.dart';
import 'package:sample_flutter_project/features/article/presentation/manager/home/home_binding.dart';
import 'package:sample_flutter_project/features/article/presentation/pages/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.homePage;
  static final routes = [
    GetPage(
        name: Routes.homePage, page: () => HomePage(), binding: HomeBinding()),
  ];
}
