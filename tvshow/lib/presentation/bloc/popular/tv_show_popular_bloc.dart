import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/domain/usecases/get_popular_tv_show.dart';

part 'tv_show_popular_event.dart';
part 'tv_show_popular_state.dart';

class TvShowPopularBloc extends Bloc<TvShowPopularEvent, TvShowPopularState> {
  final GetPopularTvShow _getPopularTvShow;

  TvShowPopularBloc(this._getPopularTvShow) : super(TvShowPopularEmpty()) {
    on<OnTvShowPopularCalled>((event, emit) async {
      emit(TvShowPopularLoading());

      final result = await _getPopularTvShow.execute();

      result.fold((failure) {
        emit(TvShowPopularError(failure.message));
      }, (data) {
        data.isEmpty
            ? emit(TvShowPopularEmpty())
            : emit(TvShowPopularHasData(data));
      });
    });
  }
}
