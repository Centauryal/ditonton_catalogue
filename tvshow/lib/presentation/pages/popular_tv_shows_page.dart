import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/tvshow.dart';

class PopularTvShowsPage extends StatefulWidget {
  const PopularTvShowsPage({Key? key}) : super(key: key);

  @override
  State<PopularTvShowsPage> createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TvShowPopularBloc>().add(const OnTvShowPopularCalled()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TvShows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvShowPopularBloc, TvShowPopularState>(
          key: const ValueKey('popular_tv_shows_page'),
          builder: (context, state) {
            if (state is TvShowPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvShowPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.result[index];
                  return TvShowCard(tvShow, key: Key('tv_show_card_$index'));
                },
                itemCount: state.result.length,
              );
            } else if (state is TvShowPopularError) {
              return Center(
                child: Text(state.message),
                key: const Key('error_message'),
              );
            } else {
              return const Center(
                child: Text(
                  'There are no one popular tv show',
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
