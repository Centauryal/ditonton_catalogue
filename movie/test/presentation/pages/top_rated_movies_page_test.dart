import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'app_helper.dart';
import 'helper/fake_pages_helper.dart';

void main() {
  late FakeMovieTopRatedBloc fakeMovieBloc;

  setUp(() {
    registerFallbackValue(FakeMovieTopRatedEvent());
    registerFallbackValue(FakeMovieTopRatedState());
    fakeMovieBloc = FakeMovieTopRatedBloc();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>(
      create: (context) => fakeMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>(
      create: (context) => fakeMovieBloc,
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) =>
        _createAnotherTestableWidget(const TopRatedMoviesPage()),
    movieDetailRoute: (context) => const FakeDestinationPage(),
  };

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state).thenReturn(MovieTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_createTestableWidget(const TopRatedMoviesPage()));

    expect(progressBarFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(const MovieTopRatedError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_createTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when empty',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state).thenReturn(MovieTopRatedEmpty());

    final textFinder = find.byKey(const Key('empty_data'));

    await tester.pumpWidget(_createTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Tapping on item should go to detail page', (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    final movieCardFinder = find.byType(MovieCard);
    expect(movieCardFinder, findsOneWidget);
    expect(find.byKey(const Key('movie_card_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_movies_page')), findsOneWidget);
    expect(find.byKey(const Key('fakeHomePage')), findsNothing);

    await tester.tap(find.byKey(const Key('movie_card_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('top_rated_movies_page')), findsNothing);
  });
}
