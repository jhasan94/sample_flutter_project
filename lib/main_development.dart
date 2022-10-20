import 'config/development.dart';

Future<void> main() async {
  final environment = Development();
  await environment.init();
}
