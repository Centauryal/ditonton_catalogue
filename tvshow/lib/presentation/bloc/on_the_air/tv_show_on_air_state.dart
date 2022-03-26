part of 'tv_show_on_air_bloc.dart';

abstract class TvShowOnAirState extends Equatable {
  const TvShowOnAirState();

  @override
  List<Object> get props => [];
}

class TvShowOnAirEmpty extends TvShowOnAirState {}

class TvShowOnAirLoading extends TvShowOnAirState {}

class TvShowOnAirError extends TvShowOnAirState {
  final String message;

  const TvShowOnAirError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowOnAirHasData extends TvShowOnAirState {
  final List<TvShow> result;

  const TvShowOnAirHasData(this.result);

  @override
  List<Object> get props => [result];
}
