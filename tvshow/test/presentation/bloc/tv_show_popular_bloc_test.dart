import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/bloc_test_helper.mocks.dart';

void main() {
  late MockGetPopularTvShow usecase;
  late TvShowPopularBloc tvShowPopularBloc;

  setUp(() {
    usecase = MockGetPopularTvShow();
    tvShowPopularBloc = TvShowPopularBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(tvShowPopularBloc.state, TvShowPopularEmpty());
  });

  blocTest<TvShowPopularBloc, TvShowPopularState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(usecase.execute()).thenAnswer((_) async => Right(testTvShowList));
        return tvShowPopularBloc;
      },
      act: (bloc) => bloc.add(const OnTvShowPopularCalled()),
      expect: () => [
            TvShowPopularLoading(),
            TvShowPopularHasData(testTvShowList),
          ],
      verify: (bloc) {
        verify(usecase.execute());
        return const OnTvShowPopularCalled().props;
      });

  blocTest<TvShowPopularBloc, TvShowPopularState>(
    'should emit [Loading, HasData] when get data is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowPopularBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowPopularCalled()),
    expect: () => [
      TvShowPopularLoading(),
      const TvShowPopularError('Server Failure'),
    ],
    verify: (bloc) => TvShowPopularLoading(),
  );

  blocTest<TvShowPopularBloc, TvShowPopularState>(
    'should emit [Loading, HasData] when get data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return tvShowPopularBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowPopularCalled()),
    expect: () => [
      TvShowPopularLoading(),
      TvShowPopularEmpty(),
    ],
  );
}