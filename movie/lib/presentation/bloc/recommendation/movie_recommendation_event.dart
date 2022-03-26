part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

class OnMovieRecommendationCalled extends MovieRecommendationEvent {
  final int id;

  const OnMovieRecommendationCalled(this.id);

  @override
  List<Object> get props => [id];
}
