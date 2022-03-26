import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetOnAirTvShow usecase;
  late TvShowOnAirBloc tvShowOnAirBloc;

  setUp(() {
    usecase = MockGetOnAirTvShow();
    tvShowOnAirBloc = TvShowOnAirBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvShowOnAirBloc.state, TvShowOnAirEmpty());
  });

  blocTest<TvShowOnAirBloc, TvShowOnAirState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(usecase.execute()).thenAnswer((_) async => Right(testTvShowList));
        return tvShowOnAirBloc;
      },
      act: (bloc) => bloc.add(const OnTvShowOnAirCalled()),
      expect: () => [
            TvShowOnAirLoading(),
            TvShowOnAirHasData(testTvShowList),
          ],
      verify: (bloc) {
        verify(usecase.execute());
        return const OnTvShowOnAirCalled().props;
      });

  blocTest<TvShowOnAirBloc, TvShowOnAirState>(
    'should emit [Loading, HasData] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowOnAirBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowOnAirCalled()),
    expect: () => [
      TvShowOnAirLoading(),
      const TvShowOnAirError('Server Failure'),
    ],
    verify: (bloc) => TvShowOnAirLoading(),
  );

  blocTest<TvShowOnAirBloc, TvShowOnAirState>(
    'should emit [Loading, HasData] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return tvShowOnAirBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowOnAirCalled()),
    expect: () => [
      TvShowOnAirLoading(),
      TvShowOnAirEmpty(),
    ],
  );
}