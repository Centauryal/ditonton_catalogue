part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieWatchlist extends WatchlistMovieEvent {}

class FetchWatchlistMovieStatus extends WatchlistMovieEvent {
  final int id;

  const FetchWatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieToWatchlist extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const AddMovieToWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMovieFromWatchlist extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const RemoveMovieFromWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
