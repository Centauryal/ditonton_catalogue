import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_show.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShow usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchTvShow(mockMovieRepository);
  });

  final tTvShow = <TvShow>[];
  final tQuery = 'The Flash';

  test('should get list of tvshows from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTvShows(tQuery))
        .thenAnswer((_) async => Right(tTvShow));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvShow));
  });
}
