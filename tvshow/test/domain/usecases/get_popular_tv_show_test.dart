import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvShow usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetPopularTvShow(mockMovieRepository);
  });

  final tTvShows = <TvShow>[];

  group('GetPopularTvShows Tests', () {
    group('execute', () {
      test(
          'should get list of tvshows from the repository when execute function is called',
          () async {
        // arrange
        when(mockMovieRepository.getPopularTvShows())
            .thenAnswer((_) async => Right(tTvShows));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvShows));
      });
    });
  });
}
