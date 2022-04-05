import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tvshow/tvshow.dart';
import 'package:watchlist/watchlist.dart';

class TvShowDetailPage extends StatefulWidget {
  final int id;

  const TvShowDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TvShowDetailPage> createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvShowDetailBloc>().add(OnTvShowDetailCalled(widget.id));
      context
          .read<TvShowRecommendationBloc>()
          .add(OnTvShowRecommendationCalled(widget.id));
      context
          .read<WatchlistTvShowBloc>()
          .add(FetchWatchlistTvShowStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    var isAddedWatchlist = context.select((WatchlistTvShowBloc bloc) =>
        bloc.state is TvShowIsAddedWatchlist
            ? (bloc.state as TvShowIsAddedWatchlist).isAdded
            : false);
    return Scaffold(
      body: BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
        key: const ValueKey('tv_show_detail_page'),
        builder: (context, state) {
          if (state is TvShowDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvShowDetailHasData) {
            final tvShow = state.result;
            return SafeArea(
              child: DetailContent(
                isAddedWatchlist,
                tvShow: tvShow,
              ),
            );
          } else if (state is TvShowDetailError) {
            return Text(
              state.message,
              key: const Key('error_message'),
            );
          } else {
            return const Center(
              child: Text(
                'Detail is empty',
                key: Key('empty_message'),
              ),
            );
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailContent extends StatefulWidget {
  final TvShowDetail tvShow;
  bool isAddedWatchlist;

  DetailContent(
    this.isAddedWatchlist, {
    Key? key,
    required this.tvShow,
  }) : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseImageUrl${widget.tvShow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvShow.name,
                              style: kHeading5,
                            ),
                            Builder(builder: (context) {
                              var message = context.select(
                                  (WatchlistTvShowBloc bloc) => bloc.state
                                          is TvShowIsAddedWatchlist
                                      ? (bloc.state as TvShowIsAddedWatchlist)
                                                  .isAdded ==
                                              false
                                          ? watchlistAddMessage
                                          : watchlistRemoveMessage
                                      : !widget.isAddedWatchlist
                                          ? watchlistAddMessage
                                          : watchlistRemoveMessage);

                              return ElevatedButton(
                                onPressed: () async {
                                  if (widget.isAddedWatchlist) {
                                    context.read<WatchlistTvShowBloc>().add(
                                        RemoveTvShowFromWatchlist(
                                            widget.tvShow));
                                  } else {
                                    context.read<WatchlistTvShowBloc>().add(
                                        AddTvShowToWatchlist(widget.tvShow));
                                  }

                                  if (message == watchlistAddMessage ||
                                      message == watchlistRemoveMessage) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(message)));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(message),
                                          );
                                        });
                                  }
                                  setState(() {
                                    widget.isAddedWatchlist =
                                        !widget.isAddedWatchlist;
                                  });
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    widget.isAddedWatchlist
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.add),
                                    const Text('Watchlist'),
                                  ],
                                ),
                              );
                            }),
                            Text(
                              _showGenres(widget.tvShow.genres),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                  '${widget.tvShow.numberOfSeasons} Season, ${widget.tvShow.numberOfEpisodes} Episode'),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvShow.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvShow.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvShow.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvShowRecommendationBloc,
                                TvShowRecommendationState>(
                              key: const ValueKey('recommendation_tv_show'),
                              builder: (context, state) {
                                if (state is TvShowRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvShowRecommendationError) {
                                  return Text(
                                    state.message,
                                    key: const Key('error_recommendation'),
                                  );
                                } else if (state
                                    is TvShowRecommendationHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvShow = state.result[index];
                                        return TvShowCardRecommendationList(
                                            index,
                                            tvShow: tvShow);
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container(
                                    key: const Key('empty_recommendation'),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
