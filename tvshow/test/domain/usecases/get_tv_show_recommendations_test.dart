import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowRecommendations usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTvShowRecommendations(mockMovieRepository);
  });

  const tId = 1;
  final tTvShows = <TvShow>[];

  test('should get list of tvshows recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getTvShowRecommendations(tId))
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvShows));
  });
}
