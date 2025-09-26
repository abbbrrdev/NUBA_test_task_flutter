import '../../domain/entities/movie.dart';

class MovieDto {
  final int id;
  final String title;
  final String? posterPath;
  final double voteAverage;

  MovieDto({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
      id: json['id'] as int,
      title: (json['title'] ?? json['name'] ?? '') as String,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] is int)
          ? (json['vote_average'] as int).toDouble()
          : (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Movie toEntity() => Movie(
        id: id,
        title: title,
        posterPath: posterPath,
        voteAverage: voteAverage,
      );
}
