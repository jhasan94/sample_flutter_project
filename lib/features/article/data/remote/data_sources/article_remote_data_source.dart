import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sample_flutter_project/core/errors/failure.dart';
import 'package:sample_flutter_project/core/network/dio/dio_service.dart';
import 'package:sample_flutter_project/core/network/end_points.dart';
import 'package:sample_flutter_project/features/article/data/remote/models/article_model.dart';
import 'package:sample_flutter_project/features/article/domain/entities/article.dart';

const String ERROR_MSG = 'Something went wrong';

class ArticleRemoteDataSource{
  final DioService client;
  ArticleRemoteDataSource({required this.client});
  Future<Either<Failure, ArticleList>> getArticles() async {
    try {
      final article = await client.get(Endpoints.getArticleEndPoint);
      final mainData = ArticleList.fromJson(article.toString());
      return Right(mainData);
    } on DioError catch (error) {
      return Left(Failure(error.message));
    } on Exception catch (_) {
      return const Left(Failure(ERROR_MSG));
    }
  }
}