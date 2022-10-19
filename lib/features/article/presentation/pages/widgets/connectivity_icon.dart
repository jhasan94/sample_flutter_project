import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_flutter_project/features/article/presentation/manager/home/home_logic.dart';

class ConnectivityIcon extends StatelessWidget {
  final HomeLogic controller;
  const ConnectivityIcon({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.connectivityResult.value) {
        case ConnectivityResult.none:
          return const Icon(
            Icons.signal_wifi_off,
            color: Colors.black,
          );
        case ConnectivityResult.mobile:
          return const Icon(
            Icons.network_cell,
            color: Colors.black,
          );
        case ConnectivityResult.wifi:
          return const Icon(
            Icons.wifi,
            color: Colors.black,
          );
        default:
          return Container();
      }
    });
  }
}
