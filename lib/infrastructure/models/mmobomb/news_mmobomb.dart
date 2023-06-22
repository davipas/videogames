class NewsMmobomb {
    final int id;
    final String title;
    final String shortDescription;
    final String thumbnail;
    final String mainImage;
    final String articleContent;
    final String articleUrl;

    NewsMmobomb({
        required this.id,
        required this.title,
        required this.shortDescription,
        required this.thumbnail,
        required this.mainImage,
        required this.articleContent,
        required this.articleUrl,
    });

    factory NewsMmobomb.fromJson(Map<String, dynamic> json) => NewsMmobomb(
        id: json["id"],
        title: json["title"],
        shortDescription: json["short_description"],
        thumbnail: json["thumbnail"],
        mainImage: json["main_image"],
        articleContent: json["article_content"],
        articleUrl: json["article_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "short_description": shortDescription,
        "thumbnail": thumbnail,
        "main_image": mainImage,
        "article_content": articleContent,
        "article_url": articleUrl,
    };
}
