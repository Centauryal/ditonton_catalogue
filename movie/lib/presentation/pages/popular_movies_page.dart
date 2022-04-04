import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<MoviePopularBloc>().add(const OnMoviePopularCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
          key: const ValueKey('popular_movies_page'),
          builder: (context, state) {
            if (state is MoviePopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviePopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(
                    movie,
                    key: Key('movie_card_$index'),
                  );
                },
                itemCount: state.result.length,
              );
            } else if (state is MoviePopularError) {
              return Center(
                child: Text(state.message),
                key: const Key('error_message'),
              );
            } else {
              return const Center(
                child: Text(
                  'There are no one popular movie',
                  key: Key('empty_data'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
