import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/domain/usecases/get_on_air_tv_show.dart';

part 'tv_show_on_air_event.dart';
part 'tv_show_on_air_state.dart';

class TvShowOnAirBloc extends Bloc<TvShowOnAirEvent, TvShowOnAirState> {
  final GetOnAirTvShow _getOnAirTvShow;

  TvShowOnAirBloc(this._getOnAirTvShow) : super(TvShowOnAirEmpty()) {
    on<OnTvShowOnAirCalled>((event, emit) async {
      emit(TvShowOnAirLoading());

      final result = await _getOnAirTvShow.execute();

      result.fold((failure) {
        emit(TvShowOnAirError(failure.message));
      }, (data) {
        data.isEmpty
            ? emit(TvShowOnAirEmpty())
            : emit(TvShowOnAirHasData(data));
      });
    });
  }
}
