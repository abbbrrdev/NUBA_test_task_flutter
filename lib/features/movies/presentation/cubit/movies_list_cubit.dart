import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';

part 'movies_list_state.dart';

class MoviesListCubit extends Cubit<MoviesListState> {
  final GetPopularMovies getPopularMovies;
  MoviesListCubit(this.getPopularMovies) : super(MoviesListInitial());

  Future<void> load({bool forceRefresh = false}) async {
    if (state is MoviesListLoading && !forceRefresh) return;
    emit(MoviesListLoading());
    try {
      final movies = await getPopularMovies();
      emit(MoviesListLoaded(movies));
    } catch (e) {
      emit(MoviesListError(e.toString()));
    }
  }
}
