import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetWatchlistTvShow getWatchlistTvShow;
  late MockGetWatchListStatus getWatchListStatus;
  late SaveWatchlistTvShow saveWatchlistTvShow;
  late RemoveWatchlistTvShow removeWatchlistTvShow;
  late WatchlistTvShowBloc watchlistTvShowBloc;

  setUp(() {
    getWatchlistTvShow = MockGetWatchlistTvShow();
    getWatchListStatus = MockGetWatchListStatus();
    saveWatchlistTvShow = MockSaveWatchlistTvShow();
    removeWatchlistTvShow = MockRemoveWatchlistTvShow();
    watchlistTvShowBloc = WatchlistTvShowBloc(
      getWatchlistTvShow,
      getWatchListStatus,
      saveWatchlistTvShow,
      removeWatchlistTvShow,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistTvShowBloc.state, WatchlistTvShowEmpty());
  });

  group(
    'watchlist tvshow',
    () {
      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(getWatchlistTvShow.execute())
              .thenAnswer((_) async => Right([testWatchlistTvShow]));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvShowWatchlist()),
        expect: () => [
          WatchlistTvShowLoading(),
          WatchlistTvShowHasData([testWatchlistTvShow]),
        ],
        verify: (bloc) {
          verify(getWatchlistTvShow.execute());
          return OnFetchTvShowWatchlist().props;
        },
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(getWatchlistTvShow.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvShowWatchlist()),
        expect: () => [
          WatchlistTvShowLoading(),
          const WatchlistTvShowError('Server Failure'),
        ],
        verify: (bloc) => WatchlistTvShowLoading(),
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'should emit [Loading, Empty] when get watchlist data is empty',
        build: () {
          when(getWatchlistTvShow.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvShowWatchlist()),
        expect: () => [
          WatchlistTvShowLoading(),
          WatchlistTvShowEmpty(),
        ],
      );
    },
  );

  group(
    'watchlist tvshow status',
    () {
      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'get status should get true when the watchlist status is true',
        build: () {
          when(getWatchListStatus.execute(testTvShowDetail.id))
              .thenAnswer((_) async => true);
          return watchlistTvShowBloc;
        },
        act: (bloc) =>
            bloc.add(FetchWatchlistTvShowStatus(testTvShowDetail.id)),
        expect: () => [
          const TvShowIsAddedWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchListStatus.execute(testTvShowDetail.id));
          return FetchWatchlistTvShowStatus(testTvShowDetail.id).props;
        },
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'get status should get false when the watchlist status is false',
        build: () {
          when(getWatchListStatus.execute(testTvShowDetail.id))
              .thenAnswer((_) async => false);
          return watchlistTvShowBloc;
        },
        act: (bloc) =>
            bloc.add(FetchWatchlistTvShowStatus(testTvShowDetail.id)),
        expect: () => [
          const TvShowIsAddedWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchListStatus.execute(testTvShowDetail.id));
          return FetchWatchlistTvShowStatus(testTvShowDetail.id).props;
        },
      );
    },
  );

  group(
    'add and remove watchlist tvshow',
    () {
      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'get update should update watchlist status when add watchlist is success',
        build: () {
          when(saveWatchlistTvShow.execute(testTvShowDetail))
              .thenAnswer((_) async => const Right(watchlistAddMessage));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(AddTvShowToWatchlist(testTvShowDetail)),
        expect: () => [
          const TvShowWatchlistMessage(watchlistAddMessage),
        ],
        verify: (bloc) {
          verify(saveWatchlistTvShow.execute(testTvShowDetail));
          return AddTvShowToWatchlist(testTvShowDetail).props;
        },
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'get status should throw failure message status when add watchlist is unsuccessful',
        build: () {
          when(saveWatchlistTvShow.execute(testTvShowDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(AddTvShowToWatchlist(testTvShowDetail)),
        expect: () => [
          const WatchlistTvShowError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveWatchlistTvShow.execute(testTvShowDetail));
          return AddTvShowToWatchlist(testTvShowDetail).props;
        },
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'get status should update watchlist status when remove watchlist is success',
        build: () {
          when(removeWatchlistTvShow.execute(testTvShowDetail))
              .thenAnswer((_) async => const Right(watchlistRemoveMessage));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(RemoveTvShowFromWatchlist(testTvShowDetail)),
        expect: () => [
          const TvShowWatchlistMessage(watchlistRemoveMessage),
        ],
        verify: (bloc) {
          verify(removeWatchlistTvShow.execute(testTvShowDetail));
          return RemoveTvShowFromWatchlist(testTvShowDetail).props;
        },
      );

      blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
        'get status should throw failure message status when remove watchlist is unsuccessful',
        build: () {
          when(removeWatchlistTvShow.execute(testTvShowDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistTvShowBloc;
        },
        act: (bloc) => bloc.add(RemoveTvShowFromWatchlist(testTvShowDetail)),
        expect: () => [
          const WatchlistTvShowError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeWatchlistTvShow.execute(testTvShowDetail));
          return RemoveTvShowFromWatchlist(testTvShowDetail).props;
        },
      );
    },
  );
}
