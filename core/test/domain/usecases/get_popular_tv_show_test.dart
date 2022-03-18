import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/get_popular_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvShow usecase;
  late MockMovieRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockMovieRepository();
    usecase = GetPopularTvShow(mockMovieRpository);
  });

  final tTvShows = <TvShow>[];

  group('GetPopularTvShows Tests', () {
    group('execute', () {
      test(
          'should get list of tvshows from the repository when execute function is called',
          () async {
        // arrange
        when(mockMovieRpository.getPopularTvShows())
            .thenAnswer((_) async => Right(tTvShows));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvShows));
      });
    });
  });
}