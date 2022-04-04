import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetNowPlayingMovies usecase;
  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    usecase = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(movieNowPlayingBloc.state, MovieNowPlayingEmpty());
  });

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(const OnMovieNowPlayingCalled()),
      expect: () => [
            MovieNowPlayingLoading(),
            MovieNowPlayingHasData(testMovieList),
          ],
      verify: (bloc) {
        verify(usecase.execute());
        return const OnMovieNowPlayingCalled().props;
      });

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'should emit [Loading, HasData] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(const OnMovieNowPlayingCalled()),
    expect: () => [
      MovieNowPlayingLoading(),
      const MovieNowPlayingError('Server Failure'),
    ],
    verify: (bloc) => MovieNowPlayingLoading(),
  );

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'should emit [Loading, HasData] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(const OnMovieNowPlayingCalled()),
    expect: () => [
      MovieNowPlayingLoading(),
      MovieNowPlayingEmpty(),
    ],
  );
}
