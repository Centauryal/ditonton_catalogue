part of 'watchlist_tv_show_bloc.dart';

abstract class WatchlistTvShowEvent extends Equatable {
  const WatchlistTvShowEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvShowWatchlist extends WatchlistTvShowEvent {}

class FetchWatchlistTvShowStatus extends WatchlistTvShowEvent {
  final int id;

  const FetchWatchlistTvShowStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvShowToWatchlist extends WatchlistTvShowEvent {
  final TvShowDetail tvShowDetail;

  const AddTvShowToWatchlist(this.tvShowDetail);

  @override
  List<Object> get props => [tvShowDetail];
}

class RemoveTvShowFromWatchlist extends WatchlistTvShowEvent {
  final TvShowDetail tvShowDetail;

  const RemoveTvShowFromWatchlist(this.tvShowDetail);

  @override
  List<Object> get props => [tvShowDetail];
}
