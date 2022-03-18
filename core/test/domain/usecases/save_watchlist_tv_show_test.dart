import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/save_watchlist_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvShow usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchlistTvShow(mockMovieRepository);
  });

  test('should save tvshow to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlistTvShow(testTvShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockMovieRepository.saveWatchlistTvShow(testTvShowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}