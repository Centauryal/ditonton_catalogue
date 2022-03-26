import 'package:core/core.dart';
import 'package:core/presentation/widgets/sub_heading_widget.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/presentation/widgets/tv_show_list.dart';
import 'package:tvshow/tvshow.dart';

class TvShowPage extends StatefulWidget {
  TvShowPage({Key? key}) : super(key: key);

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvShowOnAirBloc>().add(const OnTvShowOnAirCalled());
      context.read<TvShowPopularBloc>().add(const OnTvShowPopularCalled());
      context.read<TvShowTopRatedBloc>().add(const OnTvShowTopRatedCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, searchRoute, arguments: true);
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<TvShowOnAirBloc, TvShowOnAirState>(
                  builder: (context, state) {
                if (state is TvShowOnAirLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvShowOnAirHasData) {
                  return TvShowList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
              buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularTvShowRoute),
              ),
              BlocBuilder<TvShowPopularBloc, TvShowPopularState>(
                  builder: (context, state) {
                if (state is TvShowPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvShowPopularHasData) {
                  return TvShowList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
              buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, topRatedTvShowwRoute),
              ),
              BlocBuilder<TvShowTopRatedBloc, TvShowTopRatedState>(
                  builder: (context, state) {
                if (state is TvShowTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvShowTopRatedHasData) {
                  return TvShowList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
