import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/tvshow.dart';
import 'package:watchlist/watchlist.dart';

class FakeTvShowOnAirEvent extends Fake implements TvShowOnAirEvent {}

class FakeTvShowOnAirState extends Fake implements TvShowOnAirState {}

class FakeTvShowOnAirBloc extends MockBloc<TvShowOnAirEvent, TvShowOnAirState>
    implements TvShowOnAirBloc {}

class FakeTvShowPopularEvent extends Fake implements TvShowPopularEvent {}

class FakeTvShowPopularState extends Fake implements TvShowPopularState {}

class FakeTvShowPopularBloc
    extends MockBloc<TvShowPopularEvent, TvShowPopularState>
    implements TvShowPopularBloc {}

class FakeTvShowTopRatedEvent extends Fake implements TvShowTopRatedEvent {}

class FakeTvShowTopRatedState extends Fake implements TvShowTopRatedState {}

class FakeTvShowTopRatedBloc
    extends MockBloc<TvShowTopRatedEvent, TvShowTopRatedState>
    implements TvShowTopRatedBloc {}

class FakeTvShowDetailEvent extends Fake implements TvShowDetailEvent {}

class FakeTvShowDetailState extends Fake implements TvShowDetailState {}

class FakeTvShowDetailBloc
    extends MockBloc<TvShowDetailEvent, TvShowDetailState>
    implements TvShowDetailBloc {}

class FakeTvShowRecommendationEvent extends Fake
    implements TvShowRecommendationEvent {}

class FakeTvShowRecommendationState extends Fake
    implements TvShowRecommendationState {}

class FakeTvShowRecommendationBloc
    extends MockBloc<TvShowRecommendationEvent, TvShowRecommendationState>
    implements TvShowRecommendationBloc {}

class FakeWatchlistTvShowEvent extends Fake implements WatchlistTvShowEvent {}

class FakeWatchlistTvShowState extends Fake implements WatchlistTvShowState {}

class FakeWatchlistTvShowBloc
    extends MockBloc<WatchlistTvShowEvent, WatchlistTvShowState>
    implements WatchlistTvShowBloc {}
