import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movieb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDb movieMovieDb) {
    return Movie(
      adult: movieMovieDb.adult,
      backdropPath: movieMovieDb.backdropPath != ''
          ? "https://image.tmdb.org/t/p/w500/${movieMovieDb.backdropPath}"
          : 'https://media.istockphoto.com/id/1396814518/vector/image-coming-soon-no-photo-no-thumbnail-image-available-vector-illustration.jpg?s=612x612&w=0&k=20&c=hnh2OZgQGhf0b46-J2z7aHbIWwq8HNlSDaNp2wn_iko=',
      genreIds: movieMovieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieMovieDb.id,
      originalLanguage: movieMovieDb.originalLanguage,
      originalTitle: movieMovieDb.originalTitle,
      overview: movieMovieDb.overview,
      popularity: movieMovieDb.popularity,
      posterPath: movieMovieDb.posterPath != ''
          ? "https://image.tmdb.org/t/p/w500/${movieMovieDb.posterPath}"
          : 'https://media.istockphoto.com/id/1396814518/vector/image-coming-soon-no-photo-no-thumbnail-image-available-vector-illustration.jpg?s=612x612&w=0&k=20&c=hnh2OZgQGhf0b46-J2z7aHbIWwq8HNlSDaNp2wn_iko=',
      releaseDate: movieMovieDb.releaseDate,
      title: movieMovieDb.title,
      video: movieMovieDb.video,
      voteAverage: movieMovieDb.voteAverage,
      voteCount: movieMovieDb.voteCount,
    );
  }
}
