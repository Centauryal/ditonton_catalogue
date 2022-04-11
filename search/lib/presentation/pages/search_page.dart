import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/search_tv_show_bloc.dart';
import 'package:tvshow/tvshow.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key, required this.isTvShow}) : super(key: key);

  final bool isTvShow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isTvShow ? 'Search TV Series' : 'Search Movies'),
      ),
      body: Padding(
        key: const ValueKey('search_page'),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: isTvShow
                  ? const ValueKey('tv_show_text_field')
                  : const ValueKey('movie_text_field'),
              onChanged: (query) {
                isTvShow
                    ? context
                        .read<SearchTvShowBloc>()
                        .add(OnQueryChangedTvShow(query))
                    : context.read<SearchBloc>().add(OnQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            isTvShow
                ? BlocBuilder<SearchTvShowBloc, SearchTvShowState>(
                    builder: (context, state) {
                      if (state is SearchTvShowLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchTvShowHasData) {
                        final result = state.result;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final tvShow = result[index];
                              return TvShowCard(
                                tvShow,
                                key: Key('tv_show_card_$index'),
                              );
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else if (state is SearchTvShowError) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              state.message,
                              key: const Key('error_message'),
                            ),
                          ),
                        );
                      } else {
                        return const Expanded(
                          child: Text(
                            'Yah, Film yang kamu cari gak ada',
                            key: Key('empty_data'),
                          ),
                        );
                      }
                    },
                  )
                : BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchHasData) {
                        final result = state.result;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = result[index];
                              return MovieCard(
                                movie,
                                key: Key('movie_card_$index'),
                              );
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else if (state is SearchError) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              state.message,
                              key: const Key('error_message'),
                            ),
                          ),
                        );
                      } else {
                        return const Expanded(
                          child: Text(
                            'Yah, Film yang kamu cari gak ada',
                            key: Key('empty_data'),
                          ),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
