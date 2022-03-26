import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/domain/usecases/get_top_rated_tv_show.dart';

part 'tv_show_top_rated_event.dart';
part 'tv_show_top_rated_state.dart';

class TvShowTopRatedBloc
    extends Bloc<TvShowTopRatedEvent, TvShowTopRatedState> {
  final GetTopRatedTvShow _getTopRatedTvShow;

  TvShowTopRatedBloc(this._getTopRatedTvShow) : super(TvShowTopRatedEmpty()) {
    on<OnTvShowTopRatedCalled>((event, emit) async {
      emit(TvShowTopRatedLoading());

      final result = await _getTopRatedTvShow.execute();

      result.fold((failure) {
        emit(TvShowTopRatedError(failure.message));
      }, (data) {
        data.isEmpty
            ? emit(TvShowTopRatedEmpty())
            : emit(TvShowTopRatedHasData(data));
      });
    });
  }
}
