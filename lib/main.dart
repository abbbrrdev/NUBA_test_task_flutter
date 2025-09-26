import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/di/injection.dart';
import 'features/movies/domain/usecases/get_movie_details.dart';
import 'features/movies/domain/usecases/get_popular_movies.dart';
import 'features/movies/domain/usecases/search_movies.dart';
import 'features/movies/movies_injection.dart';
import 'features/movies/presentation/cubit/movie_details_cubit.dart';
import 'features/movies/presentation/cubit/movies_list_cubit.dart';
import 'features/movies/presentation/cubit/search_cubit.dart';
import 'features/movies/presentation/pages/movie_details_page.dart';
import 'features/movies/presentation/pages/movies_page.dart';
import 'features/movies/presentation/pages/search_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await configureDependencies();
  await registerMoviesModule();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MoviesListCubit(getIt<GetPopularMovies>())),
        BlocProvider(create: (_) => SearchCubit(getIt<SearchMovies>())),
      ],
      child: MaterialApp(
        title: 'Movies',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(builder: (_) => const MoviesPage());
          }
          if (settings.name == '/search') {
            return MaterialPageRoute(builder: (_) => const SearchPage());
          }
          if (settings.name == '/details') {
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => MovieDetailsCubit(getIt<GetMovieDetails>()),
                child: MovieDetailsPage(id: id),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
