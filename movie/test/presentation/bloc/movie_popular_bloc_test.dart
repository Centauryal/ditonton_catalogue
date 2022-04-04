import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetPopularMovies usecase;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    usecase = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(moviePopularBloc.state, MoviePopularEmpty());
  });

  blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(const OnMoviePopularCalled()),
      expect: () => [
            MoviePopularLoading(),
            MoviePopularHasData(testMovieList),
          ],
      verify: (bloc) {
        verify(usecase.execute());
        return const OnMoviePopularCalled().props;
      });

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit [Loading, HasData] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(const OnMoviePopularCalled()),
    expect: () => [
      MoviePopularLoading(),
      const MoviePopularError('Server Failure'),
    ],
    verify: (bloc) => MoviePopularLoading(),
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit [Loading, HasData] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(const OnMoviePopularCalled()),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularEmpty(),
    ],
  );
}
