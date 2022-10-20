import 'config/production.dart';

Future<void> main() async {
  final environment = Production();
  await environment.init();
}
