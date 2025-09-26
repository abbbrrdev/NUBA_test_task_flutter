import '../../domain/entities/movie_details.dart';

class MovieDetailsDto {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final List<String> genres;
  final double voteAverage;

  MovieDetailsDto({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.genres,
    required this.voteAverage,
  });

  factory MovieDetailsDto.fromJson(Map<String, dynamic> json) {
    return MovieDetailsDto(
      id: json['id'] as int,
      title: (json['title'] ?? json['name'] ?? '') as String,
      overview: (json['overview'] ?? '') as String,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String?,
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((e) => (e as Map<String, dynamic>)['name'] as String)
          .toList(),
      voteAverage: (json['vote_average'] is int)
          ? (json['vote_average'] as int).toDouble()
          : (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }

  MovieDetails toEntity() => MovieDetails(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
        backdropPath: backdropPath,
        releaseDate: releaseDate,
        genres: genres,
        voteAverage: voteAverage,
      );
}
