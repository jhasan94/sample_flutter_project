import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:sample_flutter_project/core/network/dio/dio_network_client.dart';
import 'package:sample_flutter_project/core/network/network_info.dart';
import 'package:sample_flutter_project/features/article/data/remote/data_sources/article_remote_data_source.dart';
import 'package:sample_flutter_project/features/article/data/repositories/article_repository_impl.dart';
import 'package:sample_flutter_project/features/article/domain/repositories/articles_repository.dart';
import 'package:sample_flutter_project/features/article/domain/use_cases/get_articles.dart';
import 'home_logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkInfoI>(NetworkInfo(connectivity: Connectivity()));
    Get.put(DioNetworkClient());

    Get.put(ArticleRemoteDataSource(client: Get.find()));
    Get.put<ArticleRepository>(
      ArticleRepositoryImpl(articleRemoteDataSource: Get.find()),
    );
    Get.put(GetArticlesUseCase(Get.find()));

    Get.put(HomeLogic(
      network: Get.find(),
      getRemoteArticles: Get.find(),
    ));
  }
}
