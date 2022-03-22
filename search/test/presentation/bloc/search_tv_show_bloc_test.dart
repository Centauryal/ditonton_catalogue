import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_show.dart';
import 'package:search/presentation/bloc/search_tv_show_bloc.dart';

import '../../dummy_data/mock_data.dart';
import 'search_tv_show_bloc_test.mocks.dart';

@GenerateMocks([SearchTvShow])
void main() {
  late SearchTvShowBloc searchTvShowBloc;
  late MockSearchTvShow mockSearchTvShow;

  setUp(() {
    mockSearchTvShow = MockSearchTvShow();
    searchTvShowBloc = SearchTvShowBloc(mockSearchTvShow);
  });

  group('search tvshow feature', () {
    final tTvShowList = <TvShow>[tTVShowModel];
    const tTvShowQuery = "The D'Amelio Show";

    test('initial state should be empty', () {
      expect(searchTvShowBloc.state, SearchTvShowEmpty());
    });

    blocTest<SearchTvShowBloc, SearchTvShowState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvShow.execute(tTvShowQuery))
            .thenAnswer((_) async => Right(tTvShowList));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChangedTvShow(tTvShowQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvShowLoading(),
        SearchTvShowHasData(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockSearchTvShow.execute(tTvShowQuery));
      },
    );

    blocTest<SearchTvShowBloc, SearchTvShowState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTvShow.execute(tTvShowQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChangedTvShow(tTvShowQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvShowLoading(),
        const SearchTvShowError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvShow.execute(tTvShowQuery));
      },
    );
  });
}
