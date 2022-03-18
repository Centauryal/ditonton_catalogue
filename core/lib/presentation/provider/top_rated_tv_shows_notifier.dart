import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/get_top_rated_tv_show.dart';
import 'package:flutter/material.dart';

class TopRatedTvShowsNotifier extends ChangeNotifier {
  final GetTopRatedTvShow getTopRatedTvShow;

  TopRatedTvShowsNotifier({required this.getTopRatedTvShow});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _tvShows = [];
  List<TvShow> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShow.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _state = RequestState.Loaded;
        _tvShows = tvShowData;
        notifyListeners();
      },
    );
  }
}
