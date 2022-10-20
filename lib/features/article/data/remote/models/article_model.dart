//
// import 'dart:convert';
//
// class ArticleEntity {
//   ArticleEntity({
//     required this.status,
//     required this.totalResults,
//     required this.articles,
//   });
//
//   final String status;
//   final int totalResults;
//   final List<Article> articles;
//
//   factory ArticleEntity.fromJson(String str) => ArticleEntity.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory ArticleEntity.fromMap(Map<String, dynamic> json) => ArticleEntity(
//     status: json["status"],
//     totalResults: json["totalResults"],
//     articles: List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
//   );
//
//   Map<String, dynamic> toMap() => {
//     "status": status,
//     "totalResults": totalResults,
//     "articles": List<dynamic>.from(articles.map((x) => x.toMap())),
//   };
// }
//
// class Article {
//   Article({
//     required this.source,
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//     required this.publishedAt,
//     required this.content,
//   });
//
//   final Source source;
//   final String author;
//   final String title;
//   final String description;
//   final String url;
//   final String urlToImage;
//   final DateTime publishedAt;
//   final String content;
//
//   factory Article.fromJson(String str) => Article.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Article.fromMap(Map<String, dynamic> json) => Article(
//     source: Source.fromMap(json["source"]),
//     author: json["author"] == null ? null : json["author"],
//     title: json["title"],
//     description: json["description"] == null ? null : json["description"],
//     url: json["url"],
//     urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
//     publishedAt: DateTime.parse(json["publishedAt"]),
//     content: json["content"] == null ? null : json["content"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "source": source.toMap(),
//     "author": author == null ? null : author,
//     "title": title,
//     "description": description == null ? null : description,
//     "url": url,
//     "urlToImage": urlToImage == null ? null : urlToImage,
//     "publishedAt": publishedAt.toIso8601String(),
//     "content": content == null ? null : content,
//   };
// }
//
// class Source {
//   Source({
//     required this.id,
//     required this.name,
//   });
//
//   final String id;
//   final String name;
//
//   factory Source.fromJson(String str) => Source.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Source.fromMap(Map<String, dynamic> json) => Source(
//     id: json["id"] == null ? null : json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id == null ? null : id,
//     "name": name,
//   };
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:json_annotation/json_annotation.dart';
// // import 'package:sample_flutter_project/features/article/domain/entities/article.dart';
// // part 'article_model.g.dart';
// //
// // @JsonSerializable()
// // class ArticleModel extends Article {
// //   const ArticleModel({
// //     required String title,
// //     required String content,
// //     required String url,
// //     required String urlToImage,
// //     required DateTime publishedAt
// //   }) : super(
// //       title: title,
// //       content: content,
// //       url: url,
// //       urlToImage: urlToImage,
// //       publishedAt: publishedAt);
// //
// //   factory ArticleModel.fromJson(Map<String, dynamic> json) =>
// //       _$ArticleModelFromJson(json);
// //   Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
// // }