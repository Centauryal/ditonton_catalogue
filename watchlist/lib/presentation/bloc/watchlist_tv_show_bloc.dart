import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_tv_show_event.dart';
part 'watchlist_tv_show_state.dart';

class WatchlistTvShowBloc
    extends Bloc<WatchlistTvShowEvent, WatchlistTvShowState> {
  final GetWatchlistTvShow _getWatchlistTvShow;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlistTvShow _saveWatchlistTvShow;
  final RemoveWatchlistTvShow _removeWatchlistTvShow;

  WatchlistTvShowBloc(
    this._getWatchlistTvShow,
    this._getWatchListStatus,
    this._saveWatchlistTvShow,
    this._removeWatchlistTvShow,
  ) : super(WatchlistTvShowEmpty()) {
    on<OnFetchTvShowWatchlist>(_onFetchTvShowWatchlist);
    on<FetchWatchlistTvShowStatus>(_fetchWatchlistStatus);
    on<AddTvShowToWatchlist>(_addTvShowToWatchlist);
    on<RemoveTvShowFromWatchlist>(_removeTvShowFromWatchlist);
  }

  FutureOr<void> _onFetchTvShowWatchlist(
    OnFetchTvShowWatchlist event,
    Emitter<WatchlistTvShowState> emit,
  ) async {
    emit(WatchlistTvShowLoading());

    final result = await _getWatchlistTvShow.execute();

    result.fold((failure) {
      emit(WatchlistTvShowError(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(WatchlistTvShowEmpty())
          : emit(WatchlistTvShowHasData(data));
    });
  }

  FutureOr<void> _fetchWatchlistStatus(
    FetchWatchlistTvShowStatus event,
    Emitter<WatchlistTvShowState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchListStatus.execute(id);

    emit(TvShowIsAddedWatchlist(result));
  }

  FutureOr<void> _addTvShowToWatchlist(
    AddTvShowToWatchlist event,
    Emitter<WatchlistTvShowState> emit,
  ) async {
    final tvShow = event.tvShowDetail;

    final result = await _saveWatchlistTvShow.execute(tvShow);

    result.fold((failure) {
      emit(WatchlistTvShowError(failure.message));
    }, (data) {
      emit(TvShowWatchlistMessage(data));
    });
  }

  FutureOr<void> _removeTvShowFromWatchlist(
    RemoveTvShowFromWatchlist event,
    Emitter<WatchlistTvShowState> emit,
  ) async {
    final tvShow = event.tvShowDetail;

    final result = await _removeWatchlistTvShow.execute(tvShow);

    result.fold((failure) {
      emit(WatchlistTvShowError(failure.message));
    }, (data) {
      emit(TvShowWatchlistMessage(data));
    });
  }
}
