import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/get_popular_tv_show.dart';
import 'package:core/presentation/provider/popular_tv_shows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_shows_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvShow])
void main() {
  late MockGetPopularTvShow mockGetPopularTvShow;
  late PopularTvShowsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvShow = MockGetPopularTvShow();
    notifier = PopularTvShowsNotifier(mockGetPopularTvShow)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvShow = TvShow(
    backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
    firstAirDate: "2021-09-03",
    genreIds: [10764],
    id: 130392,
    name: "The D'Amelio Show",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The D'Amelio Show",
    overview:
        "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.",
    popularity: 17.831,
    posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
    voteAverage: 9.4,
    voteCount: 2659,
  );

  final tTvShowList = <TvShow>[tTvShow];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTvShow.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    notifier.fetchPopularTvShows();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvshows data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTvShow.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    await notifier.fetchPopularTvShows();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvShows, tTvShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTvShow.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTvShows();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}