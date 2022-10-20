import 'package:dartz/dartz.dart';
import 'package:sample_flutter_project/core/errors/failure.dart';
import 'package:sample_flutter_project/features/article/domain/entities/article.dart';

abstract class ArticleRepository{
  Future<Either<Failure, ArticleList>> getArticle();
}