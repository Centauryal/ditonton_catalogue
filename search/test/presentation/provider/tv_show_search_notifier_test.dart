import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_show.dart';
import 'package:search/presentation/provider/tv_show_search_notifier.dart';

import 'tv_show_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvShow])
void main() {
  late TvShowSearchNotifier provider;
  late MockSearchTvShow mockSearchTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvShows = MockSearchTvShow();
    provider = TvShowSearchNotifier(searchTvShow: mockSearchTvShows)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvShowModel = TvShow(
    backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
    firstAirDate: "2021-09-03",
    genreIds: const [10764],
    id: 130392,
    name: "The D'Amelio Show",
    originCountry: const ["US"],
    originalLanguage: "en",
    originalName: "The D'Amelio Show",
    overview:
        "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.",
    popularity: 17.831,
    posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
    voteAverage: 9.4,
    voteCount: 2659,
  );
  final tTvShowList = <TvShow>[tTvShowModel];
  const tQuery = 'spiderman';

  group('search tvshow', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}