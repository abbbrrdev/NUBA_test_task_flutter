import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  const MovieCard({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: movie.posterPath != null
            ? CachedNetworkImage(
                imageUrl: '${AppConstants.imageBaseUrl}${movie.posterPath}',
                width: 50,
                height: 75,
                fit: BoxFit.cover,
              )
            : Container(
                width: 50,
                height: 75,
                color: Colors.grey.shade300,
                child: const Icon(Icons.movie),
              ),
      ),
      title: Text(movie.title),
      subtitle: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text(movie.voteAverage.toStringAsFixed(1)),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
