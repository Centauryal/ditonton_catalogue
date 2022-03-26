import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistMovieBloc(
    this._getWatchlistMovies,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(WatchlistMovieEmpty()) {
    on<OnFetchMovieWatchlist>(_onFetchMovieWatchlist);
    on<FetchWatchlistMovieStatus>(_fetchWatchlistStatus);
    on<AddMovieToWatchlist>(_addMovieToWatchlist);
    on<RemoveMovieFromWatchlist>(_removeMovieFromWatchlist);
  }

  FutureOr<void> _onFetchMovieWatchlist(
    OnFetchMovieWatchlist event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(WatchlistMovieLoading());

    final result = await _getWatchlistMovies.execute();

    result.fold((failure) {
      emit(WatchlistMovieError(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(WatchlistMovieEmpty())
          : emit(WatchlistMovieHasData(data));
    });
  }

  FutureOr<void> _fetchWatchlistStatus(
    FetchWatchlistMovieStatus event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchListStatus.execute(id);

    emit(MovieIsAddedWatchlist(result));
  }

  FutureOr<void> _addMovieToWatchlist(
    AddMovieToWatchlist event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    final movie = event.movieDetail;

    final result = await _saveWatchlist.execute(movie);

    result.fold((failure) {
      emit(WatchlistMovieError(failure.message));
    }, (data) {
      emit(MovieWatchlistMessage(data));
    });
  }

  FutureOr<void> _removeMovieFromWatchlist(
    RemoveMovieFromWatchlist event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    final movie = event.movieDetail;

    final result = await _removeWatchlist.execute(movie);

    result.fold((failure) {
      emit(WatchlistMovieError(failure.message));
    }, (data) {
      emit(MovieWatchlistMessage(data));
    });
  }
}
