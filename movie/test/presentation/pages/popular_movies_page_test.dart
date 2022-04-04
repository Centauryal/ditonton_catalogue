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
  late FakeMoviePopularBloc fakeMovieBloc;

  setUp(() {
    registerFallbackValue(FakeMoviePopularEvent());
    registerFallbackValue(FakeMoviePopularState());
    fakeMovieBloc = FakeMoviePopularBloc();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>(
      create: (context) => fakeMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>(
      create: (context) => fakeMovieBloc,
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) =>
        _createAnotherTestableWidget(const PopularMoviesPage()),
    movieDetailRoute: (context) => const FakeDestinationPage(),
  };

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state).thenReturn(MoviePopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_createTestableWidget(const PopularMoviesPage()));

    expect(progressBarFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(const MoviePopularError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_createTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when empty',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state).thenReturn(MoviePopularEmpty());

    final textFinder = find.byKey(const Key('empty_data'));

    await tester.pumpWidget(_createTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Tapping on item should go to detail page', (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));

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
    expect(find.byKey(const Key('popular_movies_page')), findsOneWidget);
    expect(find.byKey(const Key('fakeHomePage')), findsNothing);

    await tester.tap(find.byKey(const Key('movie_card_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('popular_movies_page')), findsNothing);
  });
}
