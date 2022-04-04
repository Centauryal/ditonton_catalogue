import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/widgets/movie_list.dart';

import '../../dummy_data/dummy_objects.dart';
import 'app_helper.dart';
import 'helper/fake_pages_helper.dart';

void main() {
  late FakeMovieNowPlayingBloc fakeMovieBloc;
  late FakeMoviePopularBloc fakePopularMovieBloc;
  late FakeMovieTopRatedBloc fakeTopRatedMovieBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieNowPlayingEvent());
    registerFallbackValue(FakeMovieNowPlayingState());
    fakeMovieBloc = FakeMovieNowPlayingBloc();

    registerFallbackValue(FakeMoviePopularEvent());
    registerFallbackValue(FakeMoviePopularState());
    fakePopularMovieBloc = FakeMoviePopularBloc();

    registerFallbackValue(FakeMovieTopRatedEvent());
    registerFallbackValue(FakeMovieTopRatedState());
    fakeTopRatedMovieBloc = FakeMovieTopRatedBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieNowPlayingBloc>(
          create: (context) => fakeMovieBloc,
        ),
        BlocProvider<MoviePopularBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<MovieTopRatedBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieNowPlayingBloc>(
          create: (context) => fakeMovieBloc,
        ),
        BlocProvider<MoviePopularBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<MovieTopRatedBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) => _createAnotherTestableWidget(const MoviePage()),
    movieDetailRoute: (context) => const FakeDestinationPage(),
    topRatedMovieRoute: (context) => const FakeDestinationPage(),
    popularMovieRoute: (context) => const FakeDestinationPage(),
    searchRoute: (context) => const FakeDestinationPage(),
  };

  testWidgets('page should display center progress bar when loading',
      (tester) async {
    when(() => fakeMovieBloc.state).thenReturn(MovieNowPlayingLoading());
    when(() => fakePopularMovieBloc.state).thenReturn(MoviePopularLoading());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(MovieTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const MoviePage()));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('page should display listview movie list when has data',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieNowPlayingHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    final listViewFinder = find.byType(ListView);
    final movieListFinder = find.byType(MovieList);

    await tester.pumpWidget(_createTestableWidget(const MoviePage()));

    expect(listViewFinder, findsNWidgets(3));
    expect(movieListFinder, findsNWidgets(3));
  });

  testWidgets('page should display error text when error', (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(const MovieNowPlayingError('Failed'));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(const MoviePopularError('Failed'));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(const MovieTopRatedError('Failed'));

    await tester.pumpWidget(_createTestableWidget(const MoviePage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  testWidgets('page should display empty text when empty', (tester) async {
    when(() => fakeMovieBloc.state).thenReturn(MovieNowPlayingEmpty());
    when(() => fakePopularMovieBloc.state).thenReturn(MoviePopularEmpty());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(MovieTopRatedEmpty());

    await tester.pumpWidget(_createTestableWidget(const MoviePage()));

    expect(find.byKey(const Key('empty_message')), findsNWidgets(3));
  });

  testWidgets('Tapping on see more (popular) should go to popular page',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieNowPlayingHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_popular')), findsOneWidget);
    expect(find.byKey(const Key('see_more_top_rated')), findsOneWidget);
    expect(find.byKey(const Key('movie_page')), findsOneWidget);

    await tester.tap(find.byKey(const Key('see_more_popular')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_popular')), findsNothing);
    expect(find.byKey(const Key('see_more_top_rated')), findsNothing);
    expect(find.byKey(const Key('movie_page')), findsNothing);
  });

  testWidgets('Tapping on see more (top rated) should go to top rated page',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieNowPlayingHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_popular')), findsOneWidget);
    expect(find.byKey(const Key('see_more_top_rated')), findsOneWidget);
    expect(find.byKey(const Key('movie_page')), findsOneWidget);

    await tester.tap(find.byKey(const Key('see_more_top_rated')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_popular')), findsNothing);
    expect(find.byKey(const Key('see_more_top_rated')), findsNothing);
    expect(find.byKey(const Key('movie_page')), findsNothing);
  });

  testWidgets('Tapping on now playing card should go to detail page',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieNowPlayingHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('movie_page')), findsOneWidget);

    await tester.tap(find.byKey(const Key('now_playing_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('movie_page')), findsNothing);
  });

  testWidgets('Tapping on popular card should go to detail page',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieNowPlayingHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('movie_page')), findsOneWidget);

    await tester.tap(find.byKey(const Key('popular_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('movie_page')), findsNothing);
  });

  testWidgets('Tapping on top rated card should go to detail page',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieNowPlayingHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(MoviePopularHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(MovieTopRatedHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('movie_page')), findsOneWidget);

    await tester.dragUntilVisible(
      find.byKey(const Key('top_rated_0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('top_rated_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('movie_page')), findsNothing);
  });
}
