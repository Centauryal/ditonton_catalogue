import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/domain/usecases/get_tv_show_recommendations.dart';

part 'tv_show_recommendation_event.dart';
part 'tv_show_recommendation_state.dart';

class TvShowRecommendationBloc
    extends Bloc<TvShowRecommendationEvent, TvShowRecommendationState> {
  final GetTvShowRecommendations _getTvShowRecommendations;

  TvShowRecommendationBloc(this._getTvShowRecommendations)
      : super(TvShowRecommendationEmpty()) {
    on<OnTvShowRecommendationCalled>((event, emit) async {
      final id = event.id;

      emit(TvShowRecommendationLoading());

      final result = await _getTvShowRecommendations.execute(id);

      result.fold((failure) {
        emit(TvShowRecommendationError(failure.message));
      }, (data) {
        emit(TvShowRecommendationHasData(data));
      });
    });
  }
}
