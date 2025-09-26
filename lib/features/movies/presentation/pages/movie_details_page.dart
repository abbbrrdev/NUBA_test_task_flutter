import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../cubit/movie_details_cubit.dart';

class MovieDetailsPage extends StatefulWidget {
  final int id;
  const MovieDetailsPage({super.key, required this.id});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsCubit>().load(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Details')),
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MovieDetailsLoaded) {
            final m = state.details;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (m.backdropPath != null)
                    CachedNetworkImage(
                      imageUrl: '${AppConstants.imageBaseUrl}${m.backdropPath}',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m.title, style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 6),
                            Text(m.releaseDate ?? '—'),
                            const SizedBox(width: 16),
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 6),
                            Text(m.voteAverage.toStringAsFixed(1)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: m.genres.map((g) => Chip(label: Text(g))).toList(),
                        ),
                        const SizedBox(height: 16),
                        Text('Overview', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text(m.overview),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          if (state is MovieDetailsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
