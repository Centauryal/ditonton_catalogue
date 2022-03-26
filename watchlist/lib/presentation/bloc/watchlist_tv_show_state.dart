part of 'watchlist_tv_show_bloc.dart';

abstract class WatchlistTvShowState extends Equatable {
  const WatchlistTvShowState();

  @override
  List<Object> get props => [];
}

class WatchlistTvShowEmpty extends WatchlistTvShowState {}

class WatchlistTvShowLoading extends WatchlistTvShowState {}

class WatchlistTvShowError extends WatchlistTvShowState {
  final String message;

  const WatchlistTvShowError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvShowHasData extends WatchlistTvShowState {
  final List<TvShow> result;

  const WatchlistTvShowHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowIsAddedWatchlist extends WatchlistTvShowState {
  final bool isAdded;

  const TvShowIsAddedWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class TvShowWatchlistMessage extends WatchlistTvShowState {
  final String message;

  const TvShowWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}
