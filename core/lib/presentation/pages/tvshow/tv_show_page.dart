import 'package:core/core.dart';
import 'package:core/presentation/provider/tv_show_list_notifier.dart';
import 'package:core/presentation/widgets/sub_heading_widget.dart';
import 'package:core/presentation/widgets/tv_show_list.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowPage extends StatefulWidget {
  TvShowPage({Key? key}) : super(key: key);

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvShowListNotifier>()
      ..fetchOnAirTvShows()
      ..fetchPopularTvShows()
      ..fetchTopRatedTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SEARCH_ROUTE,
                    arguments: true);
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.onAirState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvShowList(data.onAirTvShows);
                } else {
                  return const Text('Failed');
                }
              }),
              buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, POPULAR_TV_SHOW_ROUTE),
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.popularTvShowsState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: const CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvShowList(data.popularTvShows);
                } else {
                  return const Text('Failed');
                }
              }),
              buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TOP_RATED_TV_SHOW_ROUTE),
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTvShowsState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvShowList(data.topRatedTvShows);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
