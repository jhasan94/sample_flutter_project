import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../manager/home/home_logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
