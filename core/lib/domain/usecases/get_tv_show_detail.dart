import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class GetTvShowDetail {
  final MovieRepository repository;

  GetTvShowDetail(this.repository);

  Future<Either<Failure, TvShowDetail>> execute(int id) {
    return repository.getTvShowDetail(id);
  }
}
