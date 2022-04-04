import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvShow usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlistTvShow(mockMovieRepository);
  });

  test('should get list of tvshows from the repository', () async {
    // arrange
    when(mockMovieRepository.getWatchlistTvShows())
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvShowList));
  });
}
