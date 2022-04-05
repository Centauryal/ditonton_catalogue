import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/tvshow.dart';

class TopRatedTvShowsPage extends StatefulWidget {
  const TopRatedTvShowsPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvShowsPage> createState() => _TopRatedTvShowsPageState();
}

class _TopRatedTvShowsPageState extends State<TopRatedTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TvShowTopRatedBloc>().add(const OnTvShowTopRatedCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TvShows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvShowTopRatedBloc, TvShowTopRatedState>(
          key: const ValueKey('top_rated_tv_shows_page'),
          builder: (context, state) {
            if (state is TvShowTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvShowTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.result[index];
                  return TvShowCard(
                    tvShow,
                    key: Key('tv_show_card_$index'),
                  );
                },
                itemCount: state.result.length,
              );
            } else if (state is TvShowTopRatedError) {
              return Center(
                child: Text(state.message),
                key: const Key('error_message'),
              );
            } else {
              return const Center(
                child: Text(
                  'There are no one top rated tv show',
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
