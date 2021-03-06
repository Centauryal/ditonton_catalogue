// Mocks generated by Mockito 5.1.0 from annotations
// in search/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i8;
import 'dart:convert' as _i23;
import 'dart:typed_data' as _i24;

import 'package:core/core.dart' as _i9;
import 'package:core/data/datasources/db/database_helper.dart' as _i20;
import 'package:core/data/datasources/movie_local_data_source.dart' as _i17;
import 'package:core/data/datasources/movie_remote_data_source.dart' as _i14;
import 'package:core/data/models/movie/movie_detail_model.dart' as _i3;
import 'package:core/data/models/movie/movie_model.dart' as _i15;
import 'package:core/data/models/movie/movie_table.dart' as _i18;
import 'package:core/data/models/tvshow/tv_show_detail_model.dart' as _i4;
import 'package:core/data/models/tvshow/tv_show_model.dart' as _i16;
import 'package:core/data/models/tvshow/tv_show_table.dart' as _i19;
import 'package:core/domain/entities/movie.dart' as _i10;
import 'package:core/domain/entities/movie_detail.dart' as _i11;
import 'package:core/domain/entities/tv_show.dart' as _i12;
import 'package:core/domain/entities/tv_show_detail.dart' as _i13;
import 'package:core/domain/repositories/movie_repository.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/src/base_request.dart' as _i25;
import 'package:http/src/client.dart' as _i22;
import 'package:http/src/response.dart' as _i5;
import 'package:http/src/streamed_response.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite_sqlcipher/sqflite.dart' as _i21;

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

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i7.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, _i11.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i9.Failure, _i11.MovieDetail>>.value(
              _FakeEither_0<_i9.Failure, _i11.MovieDetail>())) as _i8
          .Future<_i2.Either<_i9.Failure, _i11.MovieDetail>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> saveWatchlist(
          _i11.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>()))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> removeWatchlist(
          _i11.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>()))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i8.Future<bool>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
              _FakeEither_0<_i9.Failure, List<_i10.Movie>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>> getOnAirTvShows() =>
      (super.noSuchMethod(Invocation.method(#getOnAirTvShows, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i12.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i12.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i12.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>> searchTvShows(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i12.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, _i13.TvShowDetail>> getTvShowDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
          returnValue: Future<_i2.Either<_i9.Failure, _i13.TvShowDetail>>.value(
              _FakeEither_0<_i9.Failure, _i13.TvShowDetail>())) as _i8
          .Future<_i2.Either<_i9.Failure, _i13.TvShowDetail>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>
      getTvShowRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getTvShowRecommendations, [id]),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i12.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> saveWatchlistTvShow(
          _i13.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlistTvShow, [tvShow]),
              returnValue: Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>()))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> removeWatchlistTvShow(
          _i13.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTvShow, [tvShow]),
              returnValue: Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>()))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>
      getWatchlistTvShows() => (super.noSuchMethod(
          Invocation.method(#getWatchlistTvShows, []),
          returnValue: Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>.value(
              _FakeEither_0<_i9.Failure, List<_i12.TvShow>>())) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i12.TvShow>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i14.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i15.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
          as _i8.Future<List<_i15.MovieModel>>);
  @override
  _i8.Future<List<_i15.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
      as _i8.Future<List<_i15.MovieModel>>);
  @override
  _i8.Future<List<_i15.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
      as _i8.Future<List<_i15.MovieModel>>);
  @override
  _i8.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as _i8.Future<_i3.MovieDetailResponse>);
  @override
  _i8.Future<List<_i15.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
          as _i8.Future<List<_i15.MovieModel>>);
  @override
  _i8.Future<List<_i15.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i15.MovieModel>>.value(<_i15.MovieModel>[]))
          as _i8.Future<List<_i15.MovieModel>>);
  @override
  _i8.Future<List<_i16.TvShowModel>> getNowPlayingTvShows() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTvShows, []),
              returnValue:
                  Future<List<_i16.TvShowModel>>.value(<_i16.TvShowModel>[]))
          as _i8.Future<List<_i16.TvShowModel>>);
  @override
  _i8.Future<List<_i16.TvShowModel>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
              returnValue:
                  Future<List<_i16.TvShowModel>>.value(<_i16.TvShowModel>[]))
          as _i8.Future<List<_i16.TvShowModel>>);
  @override
  _i8.Future<List<_i16.TvShowModel>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
              returnValue:
                  Future<List<_i16.TvShowModel>>.value(<_i16.TvShowModel>[]))
          as _i8.Future<List<_i16.TvShowModel>>);
  @override
  _i8.Future<_i4.TvShowDetailResponse> getTvShowDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
              returnValue: Future<_i4.TvShowDetailResponse>.value(
                  _FakeTvShowDetailResponse_2()))
          as _i8.Future<_i4.TvShowDetailResponse>);
  @override
  _i8.Future<List<_i16.TvShowModel>> getTvShowRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowRecommendations, [id]),
              returnValue:
                  Future<List<_i16.TvShowModel>>.value(<_i16.TvShowModel>[]))
          as _i8.Future<List<_i16.TvShowModel>>);
  @override
  _i8.Future<List<_i16.TvShowModel>> searchTvShows(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
              returnValue:
                  Future<List<_i16.TvShowModel>>.value(<_i16.TvShowModel>[]))
          as _i8.Future<List<_i16.TvShowModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i17.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<String> insertWatchlist(_i18.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<String> removeWatchlist(_i18.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<_i18.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i18.MovieTable?>.value())
          as _i8.Future<_i18.MovieTable?>);
  @override
  _i8.Future<List<_i18.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i18.MovieTable>>.value(<_i18.MovieTable>[]))
      as _i8.Future<List<_i18.MovieTable>>);
  @override
  _i8.Future<void> cacheNowPlayingMovies(List<_i18.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.Future<List<_i18.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  Future<List<_i18.MovieTable>>.value(<_i18.MovieTable>[]))
          as _i8.Future<List<_i18.MovieTable>>);
  @override
  _i8.Future<String> insertWatchlistTvShow(_i19.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTvShow, [tvShow]),
          returnValue: Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<String> removeWatchlistTvShow(_i19.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTvShow, [tvShow]),
          returnValue: Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<_i19.TvShowTable?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<_i19.TvShowTable?>.value())
          as _i8.Future<_i19.TvShowTable?>);
  @override
  _i8.Future<List<_i19.TvShowTable>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue:
                  Future<List<_i19.TvShowTable>>.value(<_i19.TvShowTable>[]))
          as _i8.Future<List<_i19.TvShowTable>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i9.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i8.Future<bool>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i20.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i21.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i21.Database?>.value())
          as _i8.Future<_i21.Database?>);
  @override
  _i8.Future<void> insertCacheTransaction(
          List<_i18.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertCacheTransaction, [movies, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i8.Future<void>);
  @override
  _i8.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheMovies, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i8.Future<List<Map<String, dynamic>>>);
  @override
  _i8.Future<int> clearCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCache, [category]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> insertWatchlist(_i18.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> removeWatchlist(_i18.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i8.Future<Map<String, dynamic>?>);
  @override
  _i8.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i8.Future<List<Map<String, dynamic>>>);
  @override
  _i8.Future<int> insertWatchlistTvShow(_i19.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTvShow, [tvShow]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> removeWatchlistTvShow(_i19.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTvShow, [tvShow]),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<List<Map<String, dynamic>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i8.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i22.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i8.Future<_i5.Response>);
  @override
  _i8.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i8.Future<_i5.Response>);
  @override
  _i8.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i23.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i8.Future<_i5.Response>);
  @override
  _i8.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i23.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i8.Future<_i5.Response>);
  @override
  _i8.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i23.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i8.Future<_i5.Response>);
  @override
  _i8.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i23.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i8.Future<_i5.Response>);
  @override
  _i8.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<_i24.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i24.Uint8List>.value(_i24.Uint8List(0)))
          as _i8.Future<_i24.Uint8List>);
  @override
  _i8.Future<_i6.StreamedResponse> send(_i25.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i6.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i8.Future<_i6.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
