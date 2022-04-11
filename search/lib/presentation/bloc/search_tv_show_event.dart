part of 'search_tv_show_bloc.dart';

abstract class SearchTvShowEvent extends Equatable {}

class OnQueryChangedTvShow extends SearchTvShowEvent {
  final String query;

  OnQueryChangedTvShow(this.query);

  @override
  List<Object> get props => [query];
}
