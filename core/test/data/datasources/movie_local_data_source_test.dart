import 'package:core/core.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test(
        'should return success message when insert movie to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test(
        'should return success message when insert tvshow to database is success',
        () async {
      when(mockDatabaseHelper.insertWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 1);

      final result = await dataSource.insertWatchlistTvShow(testTvShowTable);

      expect(result, 'Added to Watchlist');
    });

    test(
        'should throw DatabaseException when insert movie to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });

    test(
        'should throw DatabaseException when insert tvshow to database is failed',
        () async {
      when(mockDatabaseHelper.insertWatchlistTvShow(testTvShowTable))
          .thenThrow(Exception());

      final call = dataSource.insertWatchlistTvShow(testTvShowTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test(
        'should return success message when remove movie from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test(
        'should return success message when remove tvshow from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvShow(testTvShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlistTvShow(testTvShowTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test(
        'should throw DatabaseException when remove movie from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });

    test(
        'should throw DatabaseException when remove tvshow from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvShow(testTvShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistTvShow(testTvShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });

    test('should return list of TvShowTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvShows())
          .thenAnswer((_) async => [testTVShowMap]);
      // act
      final result = await dataSource.getWatchlistTvShows();
      // assert
      expect(result, [testTvShowTable]);
    });
  });

  group('cache now playing movies', () {
    test('should call database helper to save data', () async {
      when(mockDatabaseHelper.clearCache('now playing'))
          .thenAnswer((_) async => 1);
      await dataSource.cacheNowPlayingMovies([testMovieCache]);

      verify(mockDatabaseHelper.clearCache('now playing'));
      verify(mockDatabaseHelper
          .insertCacheTransaction([testMovieCache], 'now playing'));
    });

    test('should return list of movies from db when data exist', () async {
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => [testMovieCacheMap]);

      final result = await dataSource.getCachedNowPlayingMovies();

      expect(result, [testMovieCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => []);

      final call = dataSource.getCachedNowPlayingMovies();

      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
