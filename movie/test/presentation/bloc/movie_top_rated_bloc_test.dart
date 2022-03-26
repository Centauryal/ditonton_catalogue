import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetTopRatedMovies usecase;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    usecase = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(movieTopRatedBloc.state, MovieTopRatedEmpty());
  });

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(const OnMovieTopRatedCalled()),
      expect: () => [
            MovieTopRatedLoading(),
            MovieTopRatedHasData(testMovieList),
          ],
      verify: (bloc) {
        verify(usecase.execute());
        return const OnMovieTopRatedCalled().props;
      });

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'should emit [Loading, HasData] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(const OnMovieTopRatedCalled()),
    expect: () => [
      MovieTopRatedLoading(),
      const MovieTopRatedError('Server Failure'),
    ],
    verify: (bloc) => MovieTopRatedLoading(),
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'should emit [Loading, HasData] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(const OnMovieTopRatedCalled()),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedEmpty(),
    ],
  );
}
