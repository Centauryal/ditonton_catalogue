import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/domain/usecases/get_tv_show_detail.dart';

part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final GetTvShowDetail _getTvShowDetail;

  TvShowDetailBloc(this._getTvShowDetail) : super(TvShowDetailEmpty()) {
    on<OnTvShowDetailCalled>((event, emit) async {
      final id = event.id;

      emit(TvShowDetailLoading());

      final result = await _getTvShowDetail.execute(id);

      result.fold((failure) {
        emit(TvShowDetailError(failure.message));
      }, (data) {
        emit(TvShowDetailHasData(data));
      });
    });
  }
}
