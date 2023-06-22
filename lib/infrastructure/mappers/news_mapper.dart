import 'package:videogames/domain/entities/news.dart';
import 'package:videogames/infrastructure/models/mmobomb/news_mmobomb.dart';

class NewsMapper {
  static News mmobombToEntity(NewsMmobomb  newsMmobomb) => News(
      id: newsMmobomb.id,
      title: newsMmobomb.title,
      shortDescription: newsMmobomb.shortDescription,
      thumbnail: newsMmobomb.thumbnail,
      mainImage: newsMmobomb.mainImage,
      articleContent: newsMmobomb.articleContent,
      articleUrl: newsMmobomb.articleUrl);
}
