import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'app_helper.dart';
import 'helper/pages_test_helper.dart';

void main() {
  late FakeWatchlistMovieBloc fakeMovieBloc;
  late FakeWatchlistTvShowBloc fakeTvShowBloc;

  setUp(() {
    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
    fakeMovieBloc = FakeWatchlistMovieBloc();

    registerFallbackValue(FakeWatchlistTvShowEvent());
    registerFallbackValue(FakeWatchlistTvShowState());
    fakeTvShowBloc = FakeWatchlistTvShowBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMovieBloc>(
          create: (context) => fakeMovieBloc,
        ),
        BlocProvider<WatchlistTvShowBloc>(
          create: (context) => fakeTvShowBloc,
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
        BlocProvider<WatchlistMovieBloc>(
          create: (context) => fakeMovieBloc,
        ),
        BlocProvider<WatchlistTvShowBloc>(
          create: (context) => fakeTvShowBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) =>
        _createAnotherTestableWidget(const WatchlistMoviesPage()),
    movieDetailRoute: (context) => const FakeDestinationPage(),
    tvShowDetailRoute: (context) => const FakeDestinationPage(),
  };

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state).thenReturn(WatchlistMovieLoading());
    when(() => fakeTvShowBloc.state).thenReturn(WatchlistTvShowLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const WatchlistMoviesPage()));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page movie should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(const WatchlistMovieError('Failed'));
    when(() => fakeTvShowBloc.state)
        .thenReturn(const WatchlistTvShowError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_createTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsWidgets);
  });

  testWidgets('Page tvshow should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(const WatchlistMovieError('Failed'));
    when(() => fakeTvShowBloc.state)
        .thenReturn(const WatchlistTvShowError('Failed'));
    
    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('watchlist_page')), findsOneWidget);

    await tester.dragUntilVisible(
      find.byKey(const Key('tab_tv_show')),
      find.byType(TabBar),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('tab_tv_show')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_createTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsWidgets);
  });

  testWidgets('Page movie should display text with message when empty',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state).thenReturn(WatchlistMovieEmpty());
    when(() => fakeTvShowBloc.state).thenReturn(WatchlistTvShowEmpty());

    final textFinder = find.byKey(const Key('empty_data'));

    await tester.pumpWidget(_createTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page tvshow should display text with message when empty',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state).thenReturn(WatchlistMovieEmpty());
    when(() => fakeTvShowBloc.state).thenReturn(WatchlistTvShowEmpty());

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('watchlist_page')), findsOneWidget);

    await tester.dragUntilVisible(
      find.byKey(const Key('tab_tv_show')),
      find.byType(TabBar),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('tab_tv_show')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    final textFinder = find.byKey(const Key('empty_data'));

    await tester.pumpWidget(_createTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Tapping on card movie should go to movie detail page',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(WatchlistMovieHasData(testMovieList));
    when(() => fakeTvShowBloc.state)
        .thenReturn(WatchlistTvShowHasData(testTvShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('watchlist_page')), findsOneWidget);
    expect(find.byKey(const Key('movie_card_0')), findsOneWidget);

    await tester.tap(find.byKey(const Key('movie_card_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('watchlist_page')), findsNothing);
    expect(find.byKey(const Key('movie_card_0')), findsNothing);
  });

  testWidgets('Tapping on card tvshow should go to tvshow detail page',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(WatchlistMovieHasData(testMovieList));
    when(() => fakeTvShowBloc.state)
        .thenReturn(WatchlistTvShowHasData(testTvShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('watchlist_page')), findsOneWidget);
    
    await tester.dragUntilVisible(
      find.byKey(const Key('tab_tv_show')),
      find.byType(TabBar),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('tab_tv_show')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('tv_show_card_0')), findsOneWidget);

    await tester.tap(find.byKey(const Key('tv_show_card_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('watchlist_page')), findsNothing);
    expect(find.byKey(const Key('tv_show_card_0')), findsNothing);
  });
}
