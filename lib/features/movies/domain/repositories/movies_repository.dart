import '../entities/movie.dart';
import '../entities/movie_details.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Movie>> searchMovies(String query, {int page = 1});
  Future<MovieDetails> getMovieDetails(int id);
}
