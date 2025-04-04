class NewsArticle {
  final String id;
  final String title;
  final String imageUrl;
  final String link;
  final DateTime createdAt;

  NewsArticle(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.link,
      required this.createdAt});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
        id: json["id"]?? "nema id",
        title: json["title"]?? "nema naslova",
        imageUrl: json["image"] ?? "nema slike",
        link: json["link"] ?? "nema linka",
        createdAt: json["createdAt"] ?? DateTime.now());
  }

  
}
