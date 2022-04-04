import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetMovieRecommendations usecase;
  late MovieRecommendationBloc movieRecommendationBloc;

  const tId = 1;

  setUp(() {
    usecase = MockGetMovieRecommendations();
    movieRecommendationBloc = MovieRecommendationBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
  });

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(usecase.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(const OnMovieRecommendationCalled(tId)),
      expect: () => [
            MovieRecommendationLoading(),
            MovieRecommendationHasData(testMovieList),
          ],
      verify: (bloc) {
        verify(usecase.execute(tId));
        return const OnMovieRecommendationCalled(tId).props;
      });

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'should emit [Loading, HasData] when get data is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const OnMovieRecommendationCalled(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      const MovieRecommendationError('Server Failure'),
    ],
    verify: (bloc) => MovieRecommendationLoading(),
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'should emit [Loading, HasData] when get data is empty',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => const Right([]));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const OnMovieRecommendationCalled(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationEmpty(),
    ],
  );
}
