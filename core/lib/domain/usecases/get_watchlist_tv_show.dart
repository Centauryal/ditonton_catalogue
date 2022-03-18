import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class GetWatchlistTvShow {
  final MovieRepository repository;

  GetWatchlistTvShow(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getWatchlistTvShows();
  }
}
