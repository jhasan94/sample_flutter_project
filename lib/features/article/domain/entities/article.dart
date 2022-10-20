import 'dart:convert';

class ArticleList {
  ArticleList({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<Article> articles;

  factory ArticleList.fromJson(String str) =>
      ArticleList.fromMap(json.decode(str));

  factory ArticleList.fromMap(Map<String, dynamic> json) => ArticleList(
        status: json["status"],
        totalResults: json["totalResults"],
        articles:
            List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
      );
}

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  factory Article.fromJson(String str) => Article.fromMap(json.decode(str));

  factory Article.fromMap(Map<String, dynamic> json) => Article(
        source: Source.fromMap(json["source"]),
        author: json["author"] ?? "auhthor",
        title: json["title"],
        description: json["description"] ?? "description",
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? "content",
      );
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

  factory Source.fromMap(Map<String, dynamic> json) => Source(
        id: json["id"] ?? "0",
        name: json["name"] ?? "name",
      );
}
