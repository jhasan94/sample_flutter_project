import 'env.dart';

class Production extends Env{
  Production(){
    envType = EnvType.production;
    appName = 'Production';
    baseUrl = '';
  }
}