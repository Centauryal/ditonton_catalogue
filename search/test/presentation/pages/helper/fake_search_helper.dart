import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/search_tv_show_bloc.dart';

class FakeSearchEvent extends Fake implements SearchEvent {}

class FakeSearchState extends Fake implements SearchState {}

class FakeSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class FakeSearchTvShowEvent extends Fake implements SearchTvShowEvent {}

class FakeSearchTvShowState extends Fake implements SearchTvShowState {}

class FakeSearchTvShowBloc extends MockBloc<SearchTvShowEvent, SearchTvShowState>
    implements SearchTvShowBloc {}
