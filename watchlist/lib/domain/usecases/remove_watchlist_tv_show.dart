import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistTvShow {
  final MovieRepository repository;

  RemoveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return repository.removeWatchlistTvShow(tvShow);
  }
}
