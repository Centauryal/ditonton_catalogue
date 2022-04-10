import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watchlist/watchlist.dart';

class FakeWatchlistMovieEvent extends Fake implements WatchlistMovieEvent {}

class FakeWatchlistMovieState extends Fake implements WatchlistMovieState {}

class FakeWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class FakeWatchlistTvShowEvent extends Fake implements WatchlistTvShowEvent {}

class FakeWatchlistTvShowState extends Fake implements WatchlistTvShowState {}

class FakeWatchlistTvShowBloc
    extends MockBloc<WatchlistTvShowEvent, WatchlistTvShowState>
    implements WatchlistTvShowBloc {}
