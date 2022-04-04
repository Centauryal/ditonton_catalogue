import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvShow usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveWatchlistTvShow(mockMovieRepository);
  });

  test('should remove watchlist tvshow from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlistTvShow(testTvShowDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockMovieRepository.removeWatchlistTvShow(testTvShowDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
