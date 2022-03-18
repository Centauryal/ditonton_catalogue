import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/get_on_air_tv_show.dart';
import 'package:core/domain/usecases/get_popular_tv_show.dart';
import 'package:core/domain/usecases/get_top_rated_tv_show.dart';
import 'package:core/presentation/provider/tv_show_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnAirTvShow, GetPopularTvShow, GetTopRatedTvShow])
void main() {
  late TvShowListNotifier provider;
  late MockGetOnAirTvShow mockGetOnAirTvShow;
  late MockGetPopularTvShow mockGetPopularTvShow;
  late MockGetTopRatedTvShow mockGetTopRatedTvShow;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirTvShow = MockGetOnAirTvShow();
    mockGetPopularTvShow = MockGetPopularTvShow();
    mockGetTopRatedTvShow = MockGetTopRatedTvShow();
    provider = TvShowListNotifier(
      getOnAirTvShow: mockGetOnAirTvShow,
      getPopularTvShow: mockGetPopularTvShow,
      getTopRatedTvShow: mockGetTopRatedTvShow,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvShow = TvShow(
    backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
    firstAirDate: "2021-09-03",
    genreIds: [10764],
    id: 130392,
    name: "The D'Amelio Show",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The D'Amelio Show",
    overview:
        "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.",
    popularity: 17.831,
    posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
    voteAverage: 9.4,
    voteCount: 2659,
  );
  final tTvShowList = <TvShow>[tTvShow];

  group('now playing tvshow', () {
    test('initialState should be Empty', () {
      expect(provider.onAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnAirTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchOnAirTvShows();
      // assert
      verify(mockGetOnAirTvShow.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnAirTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchOnAirTvShows();
      // assert
      expect(provider.onAirState, RequestState.Loading);
    });

    test('should change tvshow when data is gotten successfully', () async {
      // arrange
      when(mockGetOnAirTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchOnAirTvShows();
      // assert
      expect(provider.onAirState, RequestState.Loaded);
      expect(provider.onAirTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnAirTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnAirTvShows();
      // assert
      expect(provider.onAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tvshows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvShowsState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tvshows data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvShowsState, RequestState.Loaded);
      expect(provider.popularTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tvshows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Loaded);
      expect(provider.topRatedTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
