import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter/material.dart';

class TvShowCardRecommendationList extends StatelessWidget {
  const TvShowCardRecommendationList(
    this.index, {
    Key? key,
    required this.tvShow,
  }) : super(key: key);

  final TvShow tvShow;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        key: Key('recommendation_$index'),
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
            imageUrl: '$baseImageUrl${tvShow.posterPath}',
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
