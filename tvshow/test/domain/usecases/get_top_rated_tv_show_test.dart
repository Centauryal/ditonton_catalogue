import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvShow usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTopRatedTvShow(mockMovieRepository);
  });

  final tTvShows = <TvShow>[];

  test('should get list of tvshows from repository', () async {
    // arrange
    when(mockMovieRepository.getTopRatedTvShows())
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvShows));
  });
}
