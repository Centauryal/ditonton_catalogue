import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:tvshow/tvshow.dart';
import 'package:watchlist/watchlist.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware, TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(OnFetchMovieWatchlist());
      context.read<WatchlistTvShowBloc>().add(OnFetchTvShowWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(OnFetchMovieWatchlist());
    context.read<WatchlistTvShowBloc>().add(OnFetchTvShowWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomDrawer(
        routes: watchlistRoute,
        content: Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.menu),
            title: const Text('Watchlist'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  key: ValueKey('tab_movie'),
                  icon: Icon(Icons.movie),
                  text: 'Movie',
                ),
                Tab(
                  key: ValueKey('tab_tv_show'),
                  icon: Icon(Icons.tv),
                  text: 'TV Series',
                )
              ],
            ),
          ),
          body: TabBarView(
            key: const ValueKey('watchlist_page'),
            controller: _tabController,
            children: [
              _itemMovieWatchlist(context),
              _itemTvShowWatchlist(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemMovieWatchlist(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieHasData) {
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
          } else if (state is WatchlistMovieError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container(
              key: const Key('empty_data'),
            );
          }
        },
      ),
    );
  }

  Widget _itemTvShowWatchlist(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvShowBloc, WatchlistTvShowState>(
        builder: (context, state) {
          if (state is WatchlistTvShowLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvShowHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = state.result[index];
                return TvShowCard(
                  tvShow,
                  key: Key('tv_show_card_$index')
                );
              },
              itemCount: state.result.length,
            );
          } else if (state is WatchlistTvShowError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container(
              key: const Key('empty_data'),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
