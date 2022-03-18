import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:core/domain/usecases/get_tv_show_detail.dart';
import 'package:core/domain/usecases/get_tv_show_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist_tv_show.dart';
import 'package:core/domain/usecases/save_watchlist_tv_show.dart';
import 'package:flutter/material.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlistTvShow saveWatchlistTvShow;
  final RemoveWatchlistTvShow removeWatchlistTvShow;

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlistTvShow,
    required this.removeWatchlistTvShow,
  });

  late TvShowDetail _tvShow;
  TvShowDetail get tvShow => _tvShow;

  RequestState _tvShowState = RequestState.Empty;
  RequestState get tvShowState => _tvShowState;

  List<TvShow> _tvShowRecommendations = [];
  List<TvShow> get tvShowRecommendations => _tvShowRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvShowDetail(int id) async {
    _tvShowState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvShowDetail.execute(id);
    final recommendationResult = await getTvShowRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShow) {
        _recommendationState = RequestState.Loading;
        _tvShow = tvShow;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvShow) {
            _recommendationState = RequestState.Loaded;
            _tvShowRecommendations = tvShow;
          },
        );
        _tvShowState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchListMessage = '';
  String get watchlistMessage => _watchListMessage;

  Future<void> addWatchlist(TvShowDetail tvShow) async {
    final result = await saveWatchlistTvShow.execute(tvShow);

    await result.fold(
      (failure) async {
        _watchListMessage = failure.message;
      },
      (successMessage) async {
        _watchListMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> removeFromWatchlist(TvShowDetail tvShow) async {
    final result = await removeWatchlistTvShow.execute(tvShow);

    await result.fold(
      (failure) async {
        _watchListMessage = failure.message;
      },
      (successMessage) async {
        _watchListMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
