class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://newsapi.org/v2/";
  static const String getArticleEndPoint = "/top-headlines?language=en&pageSize=100&apiKey=ff5fd685df97423bb19e9f75089d4e9c";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

}