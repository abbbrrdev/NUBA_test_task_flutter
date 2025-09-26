part of 'movies_list_cubit.dart';

abstract class MoviesListState {}

class MoviesListInitial extends MoviesListState {}

class MoviesListLoading extends MoviesListState {}

class MoviesListLoaded extends MoviesListState {
  final List<Movie> movies;
  MoviesListLoaded(this.movies);
}

class MoviesListError extends MoviesListState {
  final String message;
  MoviesListError(this.message);
}
