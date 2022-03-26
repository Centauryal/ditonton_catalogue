import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class TvShowCardDetailList extends StatelessWidget {
  const TvShowCardDetailList({
    Key? key,
    required this.tvShow,
  }) : super(key: key);

  final TvShow tvShow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            tvShowDetailRoute,
            arguments: tvShow.id,
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
