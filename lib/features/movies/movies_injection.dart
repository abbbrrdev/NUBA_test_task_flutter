import 'package:get_it/get_it.dart';

import '../../core/di/injection.dart';
import 'data/datasources/movies_api.dart';
import 'data/repositories/movies_repository_impl.dart';
import 'domain/repositories/movies_repository.dart';
import 'domain/usecases/get_movie_details.dart';
import 'domain/usecases/get_popular_movies.dart';
import 'domain/usecases/search_movies.dart';

Future<void> registerMoviesModule() async {
  final sl = getIt;

  sl.registerLazySingleton<MoviesApi>(() => MoviesApi());

  sl.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl(sl()));
  sl.registerFactory(() => GetPopularMovies(sl()));
  sl.registerFactory(() => SearchMovies(sl()));
  sl.registerFactory(() => GetMovieDetails(sl()));
}
