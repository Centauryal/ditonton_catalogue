part of 'search_tv_show_bloc.dart';

abstract class SearchTvShowEvent extends Equatable {
  const SearchTvShowEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedTvShow extends SearchTvShowEvent {
  final String query;

  const OnQueryChangedTvShow(this.query);

  @override
  List<Object> get props => [query];
}
