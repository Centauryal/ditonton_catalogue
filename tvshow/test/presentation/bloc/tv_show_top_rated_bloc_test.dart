import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetTopRatedTvShow usecase;
  late TvShowTopRatedBloc tvShowTopRatedBloc;

  setUp(() {
    usecase = MockGetTopRatedTvShow();
    tvShowTopRatedBloc = TvShowTopRatedBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvShowTopRatedBloc.state, TvShowTopRatedEmpty());
  });

  blocTest<TvShowTopRatedBloc, TvShowTopRatedState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(usecase.execute()).thenAnswer((_) async => Right(testTvShowList));
        return tvShowTopRatedBloc;
      },
      act: (bloc) => bloc.add(const OnTvShowTopRatedCalled()),
      expect: () => [
            TvShowTopRatedLoading(),
            TvShowTopRatedHasData(testTvShowList),
          ],
      verify: (bloc) {
        verify(usecase.execute());
        return const OnTvShowTopRatedCalled().props;
      });

  blocTest<TvShowTopRatedBloc, TvShowTopRatedState>(
    'should emit [Loading, HasData] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowTopRatedBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowTopRatedCalled()),
    expect: () => [
      TvShowTopRatedLoading(),
      const TvShowTopRatedError('Server Failure'),
    ],
    verify: (bloc) => TvShowTopRatedLoading(),
  );

  blocTest<TvShowTopRatedBloc, TvShowTopRatedState>(
    'should emit [Loading, HasData] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return tvShowTopRatedBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowTopRatedCalled()),
    expect: () => [
      TvShowTopRatedLoading(),
      TvShowTopRatedEmpty(),
    ],
  );
}
