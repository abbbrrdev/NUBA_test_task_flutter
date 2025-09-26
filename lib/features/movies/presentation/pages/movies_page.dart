import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../cubit/movies_list_cubit.dart';
import '../widgets/movie_card.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MoviesListCubit>().load();
  }

  Future<void> _onRefresh() async {
    await context.read<MoviesListCubit>().load(forceRefresh: true);
  }

  void _openSearch() {
    Navigator.of(context).pushNamed('/search');
  }

  void _openDetails(Movie movie) {
    Navigator.of(context).pushNamed('/details', arguments: movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        actions: [
          IconButton(onPressed: _openSearch, icon: const Icon(Icons.search)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<MoviesListCubit, MoviesListState>(
          builder: (context, state) {
            if (state is MoviesListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MoviesListLoaded) {
              final movies = state.movies;
              if (movies.isEmpty) {
                return const Center(child: Text('No movies'));
              }
              return ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: movies.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final m = movies[index];
                  return MovieCard(movie: m, onTap: () => _openDetails(m));
                },
              );
            } else if (state is MoviesListError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
