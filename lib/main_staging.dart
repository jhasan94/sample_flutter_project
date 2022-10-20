import 'config/staging.dart';

Future<void> main() async {
  final environment = Staging();
  await environment.init();
}
