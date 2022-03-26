part of 'tv_show_on_air_bloc.dart';

abstract class TvShowOnAirEvent extends Equatable {
  const TvShowOnAirEvent();

  @override
  List<Object> get props => [];
}

class OnTvShowOnAirCalled extends TvShowOnAirEvent {
  const OnTvShowOnAirCalled();

  @override
  List<Object> get props => [];
}
