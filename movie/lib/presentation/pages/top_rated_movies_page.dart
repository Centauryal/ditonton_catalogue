import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<MovieTopRatedBloc>().add(const OnMovieTopRatedCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
          key: const ValueKey('top_rated_movies_page'),
          builder: (context, state) {
            if (state is MovieTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieTopRatedHasData) {
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
            } else if (state is MovieTopRatedError) {
              return Center(
                child: Text(state.message),
                key: const Key('error_message'),
              );
            } else {
              return const Center(
                child: Text(
                  'There are no one top rated movie',
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
