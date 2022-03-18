import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/get_on_air_tv_show.dart';
import 'package:core/domain/usecases/get_popular_tv_show.dart';
import 'package:core/domain/usecases/get_top_rated_tv_show.dart';
import 'package:flutter/material.dart';

class TvShowListNotifier extends ChangeNotifier {
  var _onAirTvShows = <TvShow>[];
  List<TvShow> get onAirTvShows => _onAirTvShows;

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  var _popularTvShows = <TvShow>[];
  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularTvShowsState = RequestState.Empty;
  RequestState get popularTvShowsState => _popularTvShowsState;

  var _topRatedTvShows = <TvShow>[];
  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvShowsState = RequestState.Empty;
  RequestState get topRatedTvShowsState => _topRatedTvShowsState;

  String _message = '';
  String get message => _message;

  TvShowListNotifier({
    required this.getOnAirTvShow,
    required this.getPopularTvShow,
    required this.getTopRatedTvShow,
  });

  final GetOnAirTvShow getOnAirTvShow;
  final GetPopularTvShow getPopularTvShow;
  final GetTopRatedTvShow getTopRatedTvShow;

  Future<void> fetchOnAirTvShows() async {
    _onAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTvShow.execute();
    result.fold(
      (failure) {
        _onAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _onAirState = RequestState.Loaded;
        _onAirTvShows = tvShowData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShow.execute();
    result.fold(
      (failure) {
        _popularTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _popularTvShowsState = RequestState.Loaded;
        _popularTvShows = tvShowData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShow.execute();
    result.fold(
      (failure) {
        _topRatedTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _topRatedTvShowsState = RequestState.Loaded;
        _topRatedTvShows = tvShowData;
        notifyListeners();
      },
    );
  }
}
