import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetTvShowDetail usecase;
  late TvShowDetailBloc tvShowDetailBloc;

  const tId = 1;

  setUp(() {
    usecase = MockGetTvShowDetail();
    tvShowDetailBloc = TvShowDetailBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvShowDetailBloc.state, TvShowDetailEmpty());
  });

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => Right(testTvShowDetail));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowDetailCalled(tId)),
    expect: () => [
          TvShowDetailLoading(),
          TvShowDetailHasData(testTvShowDetail),
        ],
    verify: (bloc) {
      verify(usecase.execute(tId));
      return const OnTvShowDetailCalled(tId).props;
    }
  );

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'should emit [Loading, HasData] when get data is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowDetailCalled(tId)),
    expect: () => [
      TvShowDetailLoading(),
      const TvShowDetailError('Server Failure'),
    ],
    verify: (bloc) => TvShowDetailLoading(),
  );
}