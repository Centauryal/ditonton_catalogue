// Mocks generated by Mockito 5.1.0 from annotations
// in movie/test/presentation/bloc/helper/bloc_test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i6;
import 'package:core/domain/entities/movie.dart' as _i9;
import 'package:core/domain/entities/movie_detail.dart' as _i7;
import 'package:core/domain/repositories/movie_repository.dart' as _i2;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/usecases/get_movie_detail.dart' as _i4;
import 'package:movie/domain/usecases/get_movie_recommendations.dart' as _i8;
import 'package:movie/domain/usecases/get_now_playing_movies.dart' as _i10;
import 'package:movie/domain/usecases/get_popular_movies.dart' as _i11;
import 'package:movie/domain/usecases/get_top_rated_movies.dart' as _i12;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieRepository_0 extends _i1.Fake implements _i2.MovieRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetMovieDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieDetail extends _i1.Mock implements _i4.GetMovieDetail {
  MockGetMovieDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.MovieDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, _i7.MovieDetail>>.value(
              _FakeEither_1<_i6.Failure, _i7.MovieDetail>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i7.MovieDetail>>);
}

/// A class which mocks [GetMovieRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieRecommendations extends _i1.Mock
    implements _i8.GetMovieRecommendations {
  MockGetMovieRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.Movie>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.Movie>>>.value(
              _FakeEither_1<_i6.Failure, List<_i9.Movie>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.Movie>>>);
}

/// A class which mocks [GetNowPlayingMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingMovies extends _i1.Mock
    implements _i10.GetNowPlayingMovies {
  MockGetNowPlayingMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.Movie>>>.value(
              _FakeEither_1<_i6.Failure, List<_i9.Movie>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.Movie>>>);
}

/// A class which mocks [GetPopularMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularMovies extends _i1.Mock implements _i11.GetPopularMovies {
  MockGetPopularMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.Movie>>>.value(
              _FakeEither_1<_i6.Failure, List<_i9.Movie>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.Movie>>>);
}

/// A class which mocks [GetTopRatedMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedMovies extends _i1.Mock implements _i12.GetTopRatedMovies {
  MockGetTopRatedMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.Movie>>>.value(
              _FakeEither_1<_i6.Failure, List<_i9.Movie>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.Movie>>>);
}