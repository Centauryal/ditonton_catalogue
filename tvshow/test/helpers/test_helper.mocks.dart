// Mocks generated by Mockito 5.1.0 from annotations
// in tvshow/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;
import 'dart:convert' as _i24;
import 'dart:typed_data' as _i25;

import 'package:core/core.dart' as _i10;
import 'package:core/data/datasources/db/database_helper.dart' as _i21;
import 'package:core/data/datasources/movie_local_data_source.dart' as _i18;
import 'package:core/data/datasources/movie_remote_data_source.dart' as _i15;
import 'package:core/data/models/movie/movie_detail_model.dart' as _i3;
import 'package:core/data/models/movie/movie_model.dart' as _i16;
import 'package:core/data/models/movie/movie_table.dart' as _i19;
import 'package:core/data/models/tvshow/tv_show_detail_model.dart' as _i4;
import 'package:core/data/models/tvshow/tv_show_model.dart' as _i17;
import 'package:core/data/models/tvshow/tv_show_table.dart' as _i20;
import 'package:core/domain/entities/movie.dart' as _i11;
import 'package:core/domain/entities/movie_detail.dart' as _i12;
import 'package:core/domain/entities/tv_show.dart' as _i13;
import 'package:core/domain/entities/tv_show_detail.dart' as _i14;
import 'package:core/domain/repositories/movie_repository.dart' as _i8;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/io_client.dart' as _i7;
import 'package:http/src/base_request.dart' as _i26;
import 'package:http/src/client.dart' as _i23;
import 'package:http/src/response.dart' as _i5;
import 'package:http/src/streamed_response.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite_sqlcipher/sqflite.dart' as _i22;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieDetailResponse_1 extends _i1.Fake
    implements _i3.MovieDetailResponse {}

class _FakeTvShowDetailResponse_2 extends _i1.Fake
    implements _i4.TvShowDetailResponse {}

class _FakeResponse_3 extends _i1.Fake implements _i5.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i6.StreamedResponse {
}

class _FakeIOStreamedResponse_5 extends _i1.Fake
    implements _i7.IOStreamedResponse {}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i8.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>
      getNowPlayingMovies() => (super.noSuchMethod(
          Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, _i12.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i10.Failure, _i12.MovieDetail>>.value(
              _FakeEither_0<_i10.Failure, _i12.MovieDetail>())) as _i9
          .Future<_i2.Either<_i10.Failure, _i12.MovieDetail>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>
      getMovieRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> saveWatchlist(
          _i12.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>()))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> removeWatchlist(
          _i12.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>()))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);

  @override
  _i9.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i9.Future<bool>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>> getOnAirTvShows() =>
      (super.noSuchMethod(Invocation.method(#getOnAirTvShows, []),
              returnValue:
                  Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i13.TvShow>>()))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
              returnValue:
                  Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i13.TvShow>>()))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>
      getTopRatedTvShows() =>
          (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
                  returnValue:
                      Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>.value(
                          _FakeEither_0<_i10.Failure, List<_i13.TvShow>>()))
              as _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>> searchTvShows(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
              returnValue:
                  Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i13.TvShow>>()))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, _i14.TvShowDetail>> getTvShowDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
              returnValue:
                  Future<_i2.Either<_i10.Failure, _i14.TvShowDetail>>.value(
                      _FakeEither_0<_i10.Failure, _i14.TvShowDetail>()))
          as _i9.Future<_i2.Either<_i10.Failure, _i14.TvShowDetail>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>
      getTvShowRecommendations(int? id) => (super.noSuchMethod(
              Invocation.method(#getTvShowRecommendations, [id]),
              returnValue:
                  Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i13.TvShow>>()))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> saveWatchlistTvShow(
          _i14.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlistTvShow, [tvShow]),
              returnValue: Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>()))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> removeWatchlistTvShow(
          _i14.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTvShow, [tvShow]),
              returnValue: Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>()))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>
      getWatchlistTvShows() =>
          (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
                  returnValue:
                      Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>.value(
                          _FakeEither_0<_i10.Failure, List<_i13.TvShow>>()))
              as _i9.Future<_i2.Either<_i10.Failure, List<_i13.TvShow>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i15.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<List<_i16.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i16.MovieModel>>.value(<_i16.MovieModel>[]))
          as _i9.Future<List<_i16.MovieModel>>);

  @override
  _i9.Future<List<_i16.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i16.MovieModel>>.value(<_i16.MovieModel>[]))
      as _i9.Future<List<_i16.MovieModel>>);

  @override
  _i9.Future<List<_i16.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i16.MovieModel>>.value(<_i16.MovieModel>[]))
      as _i9.Future<List<_i16.MovieModel>>);

  @override
  _i9.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as _i9.Future<_i3.MovieDetailResponse>);

  @override
  _i9.Future<List<_i16.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i16.MovieModel>>.value(<_i16.MovieModel>[]))
          as _i9.Future<List<_i16.MovieModel>>);

  @override
  _i9.Future<List<_i16.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i16.MovieModel>>.value(<_i16.MovieModel>[]))
          as _i9.Future<List<_i16.MovieModel>>);

  @override
  _i9.Future<List<_i17.TvShowModel>> getNowPlayingTvShows() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTvShows, []),
              returnValue:
                  Future<List<_i17.TvShowModel>>.value(<_i17.TvShowModel>[]))
          as _i9.Future<List<_i17.TvShowModel>>);

  @override
  _i9.Future<List<_i17.TvShowModel>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
              returnValue:
                  Future<List<_i17.TvShowModel>>.value(<_i17.TvShowModel>[]))
          as _i9.Future<List<_i17.TvShowModel>>);

  @override
  _i9.Future<List<_i17.TvShowModel>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
              returnValue:
                  Future<List<_i17.TvShowModel>>.value(<_i17.TvShowModel>[]))
          as _i9.Future<List<_i17.TvShowModel>>);

  @override
  _i9.Future<_i4.TvShowDetailResponse> getTvShowDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
              returnValue: Future<_i4.TvShowDetailResponse>.value(
                  _FakeTvShowDetailResponse_2()))
          as _i9.Future<_i4.TvShowDetailResponse>);

  @override
  _i9.Future<List<_i17.TvShowModel>> getTvShowRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowRecommendations, [id]),
              returnValue:
                  Future<List<_i17.TvShowModel>>.value(<_i17.TvShowModel>[]))
          as _i9.Future<List<_i17.TvShowModel>>);

  @override
  _i9.Future<List<_i17.TvShowModel>> searchTvShows(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
              returnValue:
                  Future<List<_i17.TvShowModel>>.value(<_i17.TvShowModel>[]))
          as _i9.Future<List<_i17.TvShowModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i18.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<String> insertWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);

  @override
  _i9.Future<String> removeWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);

  @override
  _i9.Future<_i19.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i19.MovieTable?>.value())
          as _i9.Future<_i19.MovieTable?>);

  @override
  _i9.Future<List<_i19.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i19.MovieTable>>.value(<_i19.MovieTable>[]))
      as _i9.Future<List<_i19.MovieTable>>);

  @override
  _i9.Future<void> cacheNowPlayingMovies(List<_i19.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);

  @override
  _i9.Future<List<_i19.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  Future<List<_i19.MovieTable>>.value(<_i19.MovieTable>[]))
          as _i9.Future<List<_i19.MovieTable>>);

  @override
  _i9.Future<String> insertWatchlistTvShow(_i20.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTvShow, [tvShow]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);

  @override
  _i9.Future<String> removeWatchlistTvShow(_i20.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTvShow, [tvShow]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);

  @override
  _i9.Future<_i20.TvShowTable?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<_i20.TvShowTable?>.value())
          as _i9.Future<_i20.TvShowTable?>);

  @override
  _i9.Future<List<_i20.TvShowTable>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue:
                  Future<List<_i20.TvShowTable>>.value(<_i20.TvShowTable>[]))
          as _i9.Future<List<_i20.TvShowTable>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i10.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i9.Future<bool>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i21.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i22.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i22.Database?>.value())
          as _i9.Future<_i22.Database?>);

  @override
  _i9.Future<void> insertCacheTransaction(
          List<_i19.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertCacheTransaction, [movies, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);

  @override
  _i9.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheMovies, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i9.Future<List<Map<String, dynamic>>>);

  @override
  _i9.Future<int> clearCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCache, [category]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);

  @override
  _i9.Future<int> insertWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);

  @override
  _i9.Future<int> removeWatchlist(_i19.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);

  @override
  _i9.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i9.Future<Map<String, dynamic>?>);

  @override
  _i9.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i9.Future<List<Map<String, dynamic>>>);

  @override
  _i9.Future<int> insertWatchlistTvShow(_i20.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTvShow, [tvShow]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);

  @override
  _i9.Future<int> removeWatchlistTvShow(_i20.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTvShow, [tvShow]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);

  @override
  _i9.Future<List<Map<String, dynamic>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i9.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i23.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i9.Future<String>);

  @override
  _i9.Future<_i25.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i25.Uint8List>.value(_i25.Uint8List(0)))
          as _i9.Future<_i25.Uint8List>);

  @override
  _i9.Future<_i6.StreamedResponse> send(_i26.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i6.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i9.Future<_i6.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}

/// A class which mocks [IOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOClient extends _i1.Mock implements _i7.IOClient {
  MockIOClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i7.IOStreamedResponse> send(_i26.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: Future<_i7.IOStreamedResponse>.value(
                  _FakeIOStreamedResponse_5()))
          as _i9.Future<_i7.IOStreamedResponse>);

  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);

  @override
  _i9.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i24.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i9.Future<_i5.Response>);

  @override
  _i9.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i9.Future<String>);

  @override
  _i9.Future<_i25.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i25.Uint8List>.value(_i25.Uint8List(0)))
          as _i9.Future<_i25.Uint8List>);
}
