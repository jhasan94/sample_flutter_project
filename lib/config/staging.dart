import 'env.dart';

class Staging extends Env {
  Staging(){
    envType = EnvType.staging;
    appName = 'Staging';
    baseUrl = '';
  }
}