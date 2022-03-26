part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailEvent extends Equatable {
  const TvShowDetailEvent();

  @override
  List<Object> get props => [];
}

class OnTvShowDetailCalled extends TvShowDetailEvent {
  final int id;

  const OnTvShowDetailCalled(this.id);

  @override
  List<Object> get props => [id];
}
