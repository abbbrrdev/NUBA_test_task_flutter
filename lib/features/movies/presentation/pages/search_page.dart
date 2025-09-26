import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/search_cubit.dart';
import '../widgets/movie_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  void _onSubmit(String value) {
    context.read<SearchCubit>().search(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Movies')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Enter movie title',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _onSubmit(_controller.text),
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: _onSubmit,
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return const Center(child: Text('Type a query to search'));
                }
                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SearchLoaded) {
                  final movies = state.movies;
                  if (movies.isEmpty) {
                    return const Center(child: Text('No results'));
                  }
                  return ListView.separated(
                    itemCount: movies.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) => MovieCard(movie: movies[index], onTap: () {
                      Navigator.of(context).pushNamed('/details', arguments: movies[index].id);
                    }),
                  );
                }
                if (state is SearchError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}
