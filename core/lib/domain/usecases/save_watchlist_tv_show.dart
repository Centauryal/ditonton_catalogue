import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class SaveWatchlistTvShow {
  final MovieRepository repository;

  SaveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return repository.saveWatchlistTvShow(tvShow);
  }
}
