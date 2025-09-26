import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/repositories/movies_repository.dart';
import '../datasources/movies_api.dart';
import '../models/movie_details_dto.dart';
import '../models/movie_dto.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesApi api;
  MoviesRepositoryImpl(this.api);

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final results = await api.getPopularMovies(page: page);
    return results.map((e) => MovieDto.fromJson(e).toEntity()).toList();
  }

  @override
  Future<MovieDetails> getMovieDetails(int id) async {
    final json = await api.getMovieDetails(id);
    return MovieDetailsDto.fromJson(json).toEntity();
  }

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    final results = await api.searchMovies(query, page: page);
    return results.map((e) => MovieDto.fromJson(e).toEntity()).toList();
  }
}
