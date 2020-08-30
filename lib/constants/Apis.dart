class Apis {
  static const String base_url = 'http://newsapi.org/v2';
  static const String api_key = '19ccf4f14a9e42708f8c7729f391e341';
  static const String bitcoin =
      '$base_url/everything?q=bitcoin&from=2020-07-28&sortBy=publishedAt&apiKey=$api_key';
  static const String business =
      '$base_url/top-headlines?country=us&category=business&apiKey=$api_key';
  static const String apple =
      '$base_url/everything?q=apple&from=2020-08-28&to=2020-08-28&sortBy=popularity&apiKey=$api_key';
  static const String techCrunch =
      '$base_url/top-headlines?sources=techcrunch&apiKey=$api_key';
  static const String wallstreet =
      '$base_url/everything?domains=wsj.com&apiKey=$api_key';
}
