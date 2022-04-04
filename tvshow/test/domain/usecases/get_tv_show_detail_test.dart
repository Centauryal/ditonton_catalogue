import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowDetail usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTvShowDetail(mockMovieRepository);
  });

  const tId = 1;

  test('should get tvshow detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getTvShowDetail(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvShowDetail));
  });
}
