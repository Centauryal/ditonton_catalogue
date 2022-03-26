part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingEvent extends Equatable {
  const MovieNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class OnMovieNowPlayingCalled extends MovieNowPlayingEvent {
  const OnMovieNowPlayingCalled();

  @override
  List<Object> get props => [];
}
