import 'package:json_annotation/json_annotation.dart';
import 'package:sample_flutter_project/features/article/domain/entities/article.dart';
part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel extends Article {
  const ArticleModel({
    required String title,
    required String content,
    required String url,
    required String urlToImage,
    required DateTime publishedAt
  }) : super(
      title: title,
      content: content,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt);

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}