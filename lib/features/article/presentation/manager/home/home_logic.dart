import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:sample_flutter_project/core/errors/failure.dart';
import 'package:sample_flutter_project/core/network/network_info.dart';
import 'package:sample_flutter_project/core/use_cases/use_case.dart';
import 'package:sample_flutter_project/features/article/domain/entities/article.dart';
import 'package:sample_flutter_project/features/article/domain/use_cases/get_articles.dart';
import 'home_state.dart';

class HomeLogic extends GetxController {
  //final HomeState state = HomeState();

  // network info
  final NetworkInfoI network ;
  final GetArticlesUseCase getRemoteArticles ;

  HomeLogic({required this.network, required this.getRemoteArticles,});
  //final getLocalArticles = Injector.resolve<GetArticles>();

  // view state reactive value
  final viewState = ViewState.initial.obs;

  // device connectivity state reactive value
  final connectivityResult = ConnectivityResult.none.obs;

  // view state history
  final historyViewState = <ViewState>[];

  // articles data
  List<Article>? _articles;
  // articles getter
  List<Article> get articles => List.from(_articles!);
  // track local/remote articles state in view
  bool localArticlesView = false;

  @override
  Future onInit() async {
    super.onInit();
    // check for connectivity
    connectivityResult.value = await network.connectivityResult;

    if (connectivityResult.value == ConnectivityResult.none) {
      localFetch();
    } else {
      remoteFetch();
    }

    // listen to connectivity changed event and update connectivityResult value
    network.onConnectivityChanged.listen((event) {
      connectivityResult.value = event;
      // automatically evoke remote fetch if device is offline
      // and articles data is empty, null or in local view
      if (event != ConnectivityResult.none &&
          (_articles == null || _articles!.isEmpty || localArticlesView)) {
        remoteFetch();
      }
    });
  }

  @override
  void onClose() {
    // close subscriptions for rx values
    viewState.close();
    connectivityResult.close();
  }

  // fetch data from articles service
  Future<void> remoteFetch() async {
    localArticlesView = false;
    if (viewState.value == ViewState.busy) return;
    if (connectivityResult.value == ConnectivityResult.none) {
      Get.snackbar("Can't refresh when offline",
          "Please connect your device to wifi or mobile network",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    _setState(ViewState.busy);
    final result = await getRemoteArticles.call(NoParams());
    _handleFetchResult(result);
  }

  // fetch data from local database
  Future<void> localFetch() async {
    localArticlesView = true;
    if (viewState.value == ViewState.busy) return;
    _setState(ViewState.busy);
    /// We will focus in future for local storage
    //final result = await getLocalArticles.call(NoParams());
    final result = await getRemoteArticles.call(NoParams());
    _handleFetchResult(result, true);
  }

  // handle api fetch result
  void _handleFetchResult(Either<Failure, List<Article>> result,
      [bool local = false]) {
    result.fold((failure) {
      _articles?.clear();
      _setState(ViewState.error);
      Get.snackbar('Refresh failed!', "Can't load articles",
          snackPosition: SnackPosition.BOTTOM);
    }, (data) {
      _articles = data;
      _setState(ViewState.data);
      final notifyLocal = local ? '(offline mode)' : '';
      Get.snackbar('Refresh successfully!',
          ' ${_articles?.length} new articles ready for reading $notifyLocal',
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  // set view state
  void _setState(ViewState state) {
    viewState.value = state;
    historyViewState.add(state);
  }

}
