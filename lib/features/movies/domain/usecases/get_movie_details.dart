import '../entities/movie_details.dart';
import '../repositories/movies_repository.dart';

class GetMovieDetails {
  final MoviesRepository repository;
  GetMovieDetails(this.repository);

  Future<MovieDetails> call(int id) => repository.getMovieDetails(id);
}
