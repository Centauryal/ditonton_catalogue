import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import '../../domain/usecases/search_tv_show.dart';
import 'package:flutter/material.dart';

class TvShowSearchNotifier extends ChangeNotifier {
  final SearchTvShow searchTvShow;

  TvShowSearchNotifier({required this.searchTvShow});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _searchResult = [];
  List<TvShow> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvShowSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShow.execute(query);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _searchResult = data;
        notifyListeners();
      },
    );
  }
}
