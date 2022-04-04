import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetTvShowRecommendations usecase;
  late TvShowRecommendationBloc tvShowRecommendationBloc;

  const tId = 1;

  setUp(() {
    usecase = MockGetTvShowRecommendations();
    tvShowRecommendationBloc = TvShowRecommendationBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvShowRecommendationBloc.state, TvShowRecommendationEmpty());
  });

  blocTest<TvShowRecommendationBloc, TvShowRecommendationState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(usecase.execute(tId))
            .thenAnswer((_) async => Right(testTvShowList));
        return tvShowRecommendationBloc;
      },
      act: (bloc) => bloc.add(const OnTvShowRecommendationCalled(tId)),
      expect: () => [
            TvShowRecommendationLoading(),
            TvShowRecommendationHasData(testTvShowList),
          ],
      verify: (bloc) {
        verify(usecase.execute(tId));
        return const OnTvShowRecommendationCalled(tId).props;
      });

  blocTest<TvShowRecommendationBloc, TvShowRecommendationState>(
    'should emit [Loading, HasData] when get data is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowRecommendationBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowRecommendationCalled(tId)),
    expect: () => [
      TvShowRecommendationLoading(),
      const TvShowRecommendationError('Server Failure'),
    ],
    verify: (bloc) => TvShowRecommendationLoading(),
  );

  blocTest<TvShowRecommendationBloc, TvShowRecommendationState>(
    'should emit [Loading, Empty] when get data is empty',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => const Right([]));
      return tvShowRecommendationBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowRecommendationCalled(tId)),
    expect: () => [
      TvShowRecommendationLoading(),
      const TvShowRecommendationHasData([]),
    ],
  );
}
