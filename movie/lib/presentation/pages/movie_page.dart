import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/widgets/movie_list.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieNowPlayingBloc>().add(const OnMovieNowPlayingCalled());
      context.read<MoviePopularBloc>().add(const OnMoviePopularCalled());
      context.read<MovieTopRatedBloc>().add(const OnMovieTopRatedCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        key: const ValueKey('movie_page'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                builder: (context, state) {
              if (state is MovieNowPlayingLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieNowPlayingHasData) {
                return MovieList(
                  state.result,
                  valueKey: 'now_playing_',
                );
              } else if (state is MovieNowPlayingError) {
                return const Text(
                  'Failed',
                  key: Key('error_message'),
                );
              } else {
                return const Center(
                  child: Text(
                    'There are no movies currently showing',
                    key: Key('empty_message'),
                  ),
                );
              }
            }),
            buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, popularMovieRoute),
              key: const ValueKey('see_more_popular'),
            ),
            BlocBuilder<MoviePopularBloc, MoviePopularState>(
                builder: (context, state) {
              if (state is MovieTopRatedLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MoviePopularHasData) {
                return MovieList(
                  state.result,
                  valueKey: 'popular_',
                );
              } else if (state is MoviePopularError) {
                return const Text(
                  'Failed',
                  key: Key('error_message'),
                );
              } else {
                return const Center(
                  child: Text(
                    'There are no popular movie showing',
                    key: Key('empty_message'),
                  ),
                );
              }
            }),
            buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, topRatedMovieRoute),
              key: const ValueKey('see_more_top_rated'),
            ),
            BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                builder: (context, state) {
              if (state is MovieTopRatedLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieTopRatedHasData) {
                return MovieList(
                  state.result,
                  valueKey: 'top_rated_',
                );
              } else if (state is MovieTopRatedError) {
                return const Text(
                  'Failed',
                  key: Key('error_message'),
                );
              } else {
                return const Center(
                  child: Text(
                    'There are no top rated movie showing',
                    key: Key('empty_message'),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
