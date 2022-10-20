import 'package:dartz/dartz.dart';
import 'package:sample_flutter_project/core/errors/failure.dart';
import 'package:sample_flutter_project/core/use_cases/base_use_case.dart';
import 'package:sample_flutter_project/features/article/domain/entities/article.dart';
import 'package:sample_flutter_project/features/article/domain/repositories/articles_repository.dart';

class GetArticlesUseCase implements BaseUseCase<ArticleList, NoParams> {
  final ArticleRepository articleRepository;
  GetArticlesUseCase(this.articleRepository);
  @override
  Future<Either<Failure, ArticleList>> call(NoParams params) async {
    return articleRepository.getArticle();
  }
}
