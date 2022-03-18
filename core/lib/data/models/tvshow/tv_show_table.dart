import 'package:core/data/models/tvshow/tv_show_model.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class TvShowTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvShowTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvShowTable.fromEntity(TvShowDetail tvShow) => TvShowTable(
        id: tvShow.id,
        name: tvShow.name,
        posterPath: tvShow.posterPath,
        overview: tvShow.overview,
      );

  factory TvShowTable.fromMap(Map<String, dynamic> map) => TvShowTable(
        id: map['id'],
        name: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  factory TvShowTable.fromDTO(TvShowModel tvShow) => TvShowTable(
        id: tvShow.id,
        name: tvShow.name,
        posterPath: tvShow.posterPath,
        overview: tvShow.overview,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'posterPath': posterPath,
        'overview': overview,
        'type': 'tvShow'
      };

  TvShow toEntity() => TvShow.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
