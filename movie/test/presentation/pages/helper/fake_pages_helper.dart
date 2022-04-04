import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';
import 'package:watchlist/watchlist.dart';

class FakeMovieNowPlayingEvent extends Fake implements MovieNowPlayingEvent {}

class FakeMovieNowPlayingState extends Fake implements MovieNowPlayingState {}

class FakeMovieNowPlayingBloc
    extends MockBloc<MovieNowPlayingEvent, MovieNowPlayingState>
    implements MovieNowPlayingBloc {}

class FakeMoviePopularEvent extends Fake implements MoviePopularEvent {}

class FakeMoviePopularState extends Fake implements MoviePopularState {}

class FakeMoviePopularBloc
    extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}

class FakeMovieTopRatedEvent extends Fake implements MovieTopRatedEvent {}

class FakeMovieTopRatedState extends Fake implements MovieTopRatedState {}

class FakeMovieTopRatedBloc
    extends MockBloc<MovieTopRatedEvent, MovieTopRatedState>
    implements MovieTopRatedBloc {}

class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

class FakeMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class FakeMovieRecommendationEvent extends Fake
    implements MovieRecommendationEvent {}

class FakeMovieRecommendationState extends Fake
    implements MovieRecommendationState {}

class FakeMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class FakeWatchlistMovieEvent extends Fake implements WatchlistMovieEvent {}

class FakeWatchlistMovieState extends Fake implements WatchlistMovieState {}

class FakeWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}
