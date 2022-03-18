import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/get_tv_show_detail.dart';
import 'package:core/domain/usecases/get_tv_show_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist_tv_show.dart';
import 'package:core/domain/usecases/save_watchlist_tv_show.dart';
import 'package:core/presentation/provider/tv_show_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetWatchListStatus,
  SaveWatchlistTvShow,
  RemoveWatchlistTvShow,
])
void main() {
  late TvShowDetailNotifier provider;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvshowRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTvShow mockSaveWatchlistTvShow;
  late MockRemoveWatchlistTvShow mockRemoveWatchlistTvShow;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvshowRecommendations = MockGetTvShowRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlistTvShow = MockSaveWatchlistTvShow();
    mockRemoveWatchlistTvShow = MockRemoveWatchlistTvShow();
    provider = TvShowDetailNotifier(
      getTvShowDetail: mockGetTvShowDetail,
      getTvShowRecommendations: mockGetTvshowRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlistTvShow: mockSaveWatchlistTvShow,
      removeWatchlistTvShow: mockRemoveWatchlistTvShow,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tTvShow = TvShow(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1],
    id: 1,
    name: 'name',
    originCountry: ["US"],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvShows = <TvShow>[tTvShow];

  void _arrangeUsecase() {
    when(mockGetTvShowDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    when(mockGetTvshowRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvShows));
  }

  group('Get TvShow Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvshowRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tvshow when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShow, testTvShowDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tvshow when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShowRecommendations, tTvShows);
    });
  });

  group('Get TvShows Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      verify(mockGetTvshowRecommendations.execute(tId));
      expect(provider.tvShowRecommendations, tTvShows);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvShowRecommendations, tTvShows);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      when(mockGetTvshowRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockSaveWatchlistTvShow.execute(testTvShowDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvShowDetail);
      // assert
      verify(mockRemoveWatchlistTvShow.execute(testTvShowDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testTvShowDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvshowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvShows));
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}