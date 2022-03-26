part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnMovieDetailCalled extends MovieDetailEvent {
  final int id;

  const OnMovieDetailCalled(this.id);

  @override
  List<Object> get props => [id];
}
