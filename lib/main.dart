import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sample_flutter_project/routes/app_pages.dart';


void main() {
  runApp(
     GetMaterialApp(
      title: "Application",
       debugShowCheckedModeBanner: false,
       initialRoute: AppPages.INITIAL,
       getPages: AppPages.routes,
       defaultTransition: Transition.topLevel,
    ),
  );
}
