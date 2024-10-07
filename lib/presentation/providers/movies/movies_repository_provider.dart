import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repository/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// using "Provider" is for readonly data
final movieRepositoryProvider = Provider((ref) => MoviesRepositoryImpl(
      moviesDatasource: MovieDBDatasourceImpl(),
    ));
