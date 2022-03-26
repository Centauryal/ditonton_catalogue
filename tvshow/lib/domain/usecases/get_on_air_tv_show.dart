import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetOnAirTvShow {
  final MovieRepository repository;

  GetOnAirTvShow(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getOnAirTvShows();
  }
}
