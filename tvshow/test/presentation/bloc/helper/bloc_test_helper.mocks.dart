// Mocks generated by Mockito 5.1.0 from annotations
// in tvshow/test/presentation/bloc/helper/bloc_test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i6;
import 'package:core/domain/entities/tv_show.dart' as _i7;
import 'package:core/domain/entities/tv_show_detail.dart' as _i12;
import 'package:core/domain/repositories/movie_repository.dart' as _i2;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tvshow/domain/usecases/get_on_air_tv_show.dart' as _i4;
import 'package:tvshow/domain/usecases/get_popular_tv_show.dart' as _i8;
import 'package:tvshow/domain/usecases/get_top_rated_tv_show.dart' as _i9;
import 'package:tvshow/domain/usecases/get_tv_show_detail.dart' as _i11;
import 'package:tvshow/domain/usecases/get_tv_show_recommendations.dart'
    as _i10;

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

/// A class which mocks [GetOnAirTvShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetOnAirTvShow extends _i1.Mock implements _i4.GetOnAirTvShow {
  MockGetOnAirTvShow() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>);
}

/// A class which mocks [GetPopularTvShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularTvShow extends _i1.Mock implements _i8.GetPopularTvShow {
  MockGetPopularTvShow() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>);
}

/// A class which mocks [GetTopRatedTvShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedTvShow extends _i1.Mock implements _i9.GetTopRatedTvShow {
  MockGetTopRatedTvShow() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>);
}

/// A class which mocks [GetTvShowRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvShowRecommendations extends _i1.Mock
    implements _i10.GetTvShowRecommendations {
  MockGetTvShowRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>);
}

/// A class which mocks [GetTvShowDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvShowDetail extends _i1.Mock implements _i11.GetTvShowDetail {
  MockGetTvShowDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i12.TvShowDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, _i12.TvShowDetail>>.value(
              _FakeEither_1<_i6.Failure, _i12.TvShowDetail>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i12.TvShowDetail>>);
}
