part of 'tv_show_recommendation_bloc.dart';

abstract class TvShowRecommendationEvent extends Equatable {
  const TvShowRecommendationEvent();

  @override
  List<Object> get props => [];
}

class OnTvShowRecommendationCalled extends TvShowRecommendationEvent {
  final int id;

  const OnTvShowRecommendationCalled(this.id);

  @override
  List<Object> get props => [id];
}
