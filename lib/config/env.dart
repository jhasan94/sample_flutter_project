import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:sample_flutter_project/routes/app_pages.dart';

import '../core/logging/log.dart';

enum EnvType { development, staging, production }

class Env {
  Env() {
    value = this;
  }

  static late Env value;
  late String appName;
  late String baseUrl;
  late EnvType envType;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Log.init();
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.topLevel,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}
