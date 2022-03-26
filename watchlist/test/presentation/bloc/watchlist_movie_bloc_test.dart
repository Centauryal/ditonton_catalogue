import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetWatchlistMovies getWatchlistMovie;
  late MockGetWatchListStatus getWatchListStatus;
  late SaveWatchlist saveWatchlist;
  late RemoveWatchlist removeWatchlist;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    getWatchlistMovie = MockGetWatchlistMovies();
    getWatchListStatus = MockGetWatchListStatus();
    saveWatchlist = MockSaveWatchlist();
    removeWatchlist = MockRemoveWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(
      getWatchlistMovie,
      getWatchListStatus,
      saveWatchlist,
      removeWatchlist,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
  });

  group(
    'watchlist Movie', () {
      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(getWatchlistMovie.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchlist()),
        expect: () => [
          WatchlistMovieLoading(),
          WatchlistMovieHasData([testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(getWatchlistMovie.execute());
          return OnFetchMovieWatchlist().props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(getWatchlistMovie.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchlist()),
        expect: () => [
          WatchlistMovieLoading(),
          const WatchlistMovieError('Server Failure'),
        ],
        verify: (bloc) => WatchlistMovieLoading(),
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should emit [Loading, Empty] when get watchlist data is empty',
        build: () {
          when(getWatchlistMovie.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchlist()),
        expect: () => [
          WatchlistMovieLoading(),
          WatchlistMovieEmpty(),
        ],
      );
    },
  );

  group(
    'watchlist Movie status', () {
      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'get status should get true when the watchlist status is true',
        build: () {
          when(getWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistMovieStatus(testMovieDetail.id)),
        expect: () => [
          const MovieIsAddedWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchListStatus.execute(testMovieDetail.id));
          return FetchWatchlistMovieStatus(testMovieDetail.id).props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'get status should get false when the watchlist status is false',
        build: () {
          when(getWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistMovieStatus(testMovieDetail.id)),
        expect: () => [
          const MovieIsAddedWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchListStatus.execute(testMovieDetail.id));
          return FetchWatchlistMovieStatus(testMovieDetail.id).props;
        },
      );
    },
  );

  group(
    'add and remove watchlist Movie',
    () {
      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'get update should update watchlist status when add watchlist is success',
        build: () {
          when(saveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right(watchlistAddMessage));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
        expect: () => [
          const MovieWatchlistMessage(watchlistAddMessage),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
          return AddMovieToWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'get status should throw failure message status when add watchlist is unsuccessful',
        build: () {
          when(saveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
        expect: () => [
          const WatchlistMovieError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
          return AddMovieToWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'get status should update watchlist status when remove watchlist is success',
        build: () {
          when(removeWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveMessage));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
        expect: () => [
          const MovieWatchlistMessage(watchlistRemoveMessage),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
          return RemoveMovieFromWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'get status should throw failure message status when remove watchlist is unsuccessful',
        build: () {
          when(removeWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
        expect: () => [
          const WatchlistMovieError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
          return RemoveMovieFromWatchlist(testMovieDetail).props;
        },
      );
    },
  );
}