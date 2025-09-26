import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie_details.dart';
import '../../domain/usecases/get_movie_details.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetails getMovieDetails;
  MovieDetailsCubit(this.getMovieDetails) : super(MovieDetailsInitial());

  Future<void> load(int id) async {
    emit(MovieDetailsLoading());
    try {
      final details = await getMovieDetails(id);
      emit(MovieDetailsLoaded(details));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }
}
