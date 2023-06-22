import 'package:dio/dio.dart';
import 'package:videogames/domain/datasources/news_datasource.dart';
import 'package:videogames/domain/entities/news.dart';
import 'package:videogames/infrastructure/mappers/news_mapper.dart';
import 'package:videogames/infrastructure/models/mmobomb/news_mmobomb.dart';

class NewsMmobombDatasource extends NewsDatasource {

    final dio = Dio(BaseOptions(
    baseUrl: 'https://www.mmobomb.com/api1'
  ));
  @override
  Future<List<News>> getLatestnews() async{
    final response = await dio.get('/latestnews');
    final List<dynamic> responseData = response.data;

    final List<News> news = responseData.map((newsData) {
      final mmobombResponse = NewsMmobomb.fromJson(newsData);
      return NewsMapper.mmobombToEntity(mmobombResponse);
    }).toList();
    return news;
  }

}