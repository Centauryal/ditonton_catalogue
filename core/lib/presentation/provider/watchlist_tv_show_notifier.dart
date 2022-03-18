import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/get_watchlist_tv_show.dart';
import 'package:flutter/material.dart';

class WatchlistTvShowNotifier extends ChangeNotifier {
  var _watchlistTvShows = <TvShow>[];
  List<TvShow> get watchlistTvShows => _watchlistTvShows;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvShowNotifier({required this.getWatchlistTvShow});

  final GetWatchlistTvShow getWatchlistTvShow;

  Future<void> fetchWatchlistTvShows() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvShow.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvShows = tvShowData;
        notifyListeners();
      },
    );
  }
}
