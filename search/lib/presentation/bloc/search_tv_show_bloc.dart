import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:search/domain/usecases/search_tv_show.dart';
import 'package:search/presentation/utils/event_transformer.dart';

part 'search_tv_show_event.dart';
part 'search_tv_show_state.dart';

class SearchTvShowBloc extends Bloc<SearchTvShowEvent, SearchTvShowState> {
  final SearchTvShow _searchTvShows;

  SearchTvShowBloc(this._searchTvShows) : super(SearchTvShowEmpty()) {
    on<OnQueryChangedTvShow>(
      (event, emit) async {
        final query = event.query;

        emit(SearchTvShowLoading());
        final result = await _searchTvShows.execute(query);

        result.fold((failure) {
          emit(SearchTvShowError(failure.message));
        }, (data) {
          emit(SearchTvShowHasData(data));
        });
      },
      transformer: debounce(const Duration(milliseconds: 500)));
  }
}
