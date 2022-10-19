import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String title;
  final String content;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;

  const Article(
      {required this.title,
      required this.content,
      required this.url,
      required this.urlToImage,
      required this.publishedAt});

  @override
  List<Object?> get props => [title, content, url, urlToImage, publishedAt];
}
