import 'package:dartz/dartz.dart';
import 'package:sample_flutter_project/core/errors/failure.dart';
import 'package:sample_flutter_project/features/article/data/remote/data_sources/article_remote_data_source.dart';
import 'package:sample_flutter_project/features/article/domain/entities/article.dart';
import 'package:sample_flutter_project/features/article/domain/repositories/articles_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository{

  final ArticleRemoteDataSource articleRemoteDataSource;

  ArticleRepositoryImpl({required this.articleRemoteDataSource});
  @override
  Future<Either<Failure, ArticleList>> getArticle() async{
    try {
      final response = await articleRemoteDataSource.getArticles();
      return response.fold((failure) => Left(failure), (articles) async {
        if (articles.articles.isNotEmpty) {
          return Right(articles);
        }
        return const Left(Failure('Can not find articles right now'));
      });
    } on Exception catch (_) {
      return const Left(Failure('Something went wrong'));
    }
  }

}