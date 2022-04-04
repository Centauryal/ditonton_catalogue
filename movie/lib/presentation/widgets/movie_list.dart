import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final String valueKey;

  const MovieList(
    this.movies, {
    Key? key,
    required this.valueKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
              padding: const EdgeInsets.all(8),
              child: Material(
                child: InkWell(
                  key: ValueKey('$valueKey$index'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      movieDetailRoute,
                      arguments: movie.id,
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: CachedNetworkImage(
                      imageUrl: '$baseImageUrl${movie.posterPath}',
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ));
        },
        itemCount: movies.length,
      ),
    );
  }
}
