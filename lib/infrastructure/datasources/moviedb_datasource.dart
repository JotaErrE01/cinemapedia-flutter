import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movieb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovieDBDatasourceImpl implements MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {
        'api_key': Environment.movieApiKey,
        'language': 'en-US',
      },
    ),
  );

  @override
  Future<List<Movie>> getMoviesNowPlaying({int page = 1}) async {
    final response = await dio.get('movie/now_playing');

    final movieDbResponse = MovieDbResponse.fromJson(response.data);
    // final List<Movie> movies = MovieMapper

    // return movies;
  }
}
