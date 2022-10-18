import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sample_flutter_project/core/errors/failure.dart';
import 'package:sample_flutter_project/features/article/data/remote/models/article_model.dart';

const String ERROR_MSG = 'Something went wrong';
class ArticleRemoteDataSource{
  final NetworkClient client;
  ArticleRemoteDataSource({required this.client});
  Future<Either<Failure, List<ArticleModel>>> getArticles() async {
    try {
      final articles = await client.getTopHeadlines();
      return Right(articles);
    } on DioError catch (error) {
      return Left(Failure(error.message));
    } on Exception catch (_) {
      return const Left(Failure(ERROR_MSG));
    }
  }
}