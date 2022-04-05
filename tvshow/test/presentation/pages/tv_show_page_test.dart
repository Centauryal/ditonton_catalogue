import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshow/presentation/widgets/tv_show_list.dart';
import 'package:tvshow/tvshow.dart';

import '../../dummy_data/dummy_objects.dart';
import 'app_helper.dart';
import 'helper/fake_pages_helper.dart';

void main() {
  late FakeTvShowOnAirBloc fakeTvShowBloc;
  late FakeTvShowPopularBloc fakePopularTvShowBloc;
  late FakeTvShowTopRatedBloc fakeTopRatedTvShowBloc;

  setUpAll(() {
    registerFallbackValue(FakeTvShowOnAirEvent());
    registerFallbackValue(FakeTvShowOnAirState());
    fakeTvShowBloc = FakeTvShowOnAirBloc();

    registerFallbackValue(FakeTvShowPopularEvent());
    registerFallbackValue(FakeTvShowPopularState());
    fakePopularTvShowBloc = FakeTvShowPopularBloc();

    registerFallbackValue(FakeTvShowTopRatedEvent());
    registerFallbackValue(FakeTvShowTopRatedState());
    fakeTopRatedTvShowBloc = FakeTvShowTopRatedBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvShowOnAirBloc>(
          create: (context) => fakeTvShowBloc,
        ),
        BlocProvider<TvShowPopularBloc>(
          create: (context) => fakePopularTvShowBloc,
        ),
        BlocProvider<TvShowTopRatedBloc>(
          create: (context) => fakeTopRatedTvShowBloc,
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
        BlocProvider<TvShowOnAirBloc>(
          create: (context) => fakeTvShowBloc,
        ),
        BlocProvider<TvShowPopularBloc>(
          create: (context) => fakePopularTvShowBloc,
        ),
        BlocProvider<TvShowTopRatedBloc>(
          create: (context) => fakeTopRatedTvShowBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) => _createAnotherTestableWidget(const TvShowPage()),
    tvShowDetailRoute: (context) => const FakeDestinationPage(),
    topRatedTvShowRoute: (context) => const FakeDestinationPage(),
    popularTvShowRoute: (context) => const FakeDestinationPage(),
    searchRoute: (context) => const FakeDestinationPage(),
  };

  testWidgets('page should display center progress bar when loading',
      (tester) async {
    when(() => fakeTvShowBloc.state).thenReturn(TvShowOnAirLoading());
    when(() => fakePopularTvShowBloc.state).thenReturn(TvShowPopularLoading());
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TvShowTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const TvShowPage()));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('page should display listview tvshow list when has data',
      (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowOnAirHasData(testTvShowList));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(TvShowPopularHasData(testTvShowList));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TvShowTopRatedHasData(testTvShowList));

    final listViewFinder = find.byType(ListView);
    final tvShowListFinder = find.byType(TvShowList);

    await tester.pumpWidget(_createTestableWidget(const TvShowPage()));

    expect(listViewFinder, findsNWidgets(3));
    expect(tvShowListFinder, findsNWidgets(3));
  });

  testWidgets('page should display error text when error', (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(const TvShowOnAirError('Failed'));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(const TvShowPopularError('Failed'));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(const TvShowTopRatedError('Failed'));

    await tester.pumpWidget(_createTestableWidget(const TvShowPage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  testWidgets('page should display empty text when empty', (tester) async {
    when(() => fakeTvShowBloc.state).thenReturn(TvShowOnAirEmpty());
    when(() => fakePopularTvShowBloc.state).thenReturn(TvShowPopularEmpty());
    when(() => fakeTopRatedTvShowBloc.state).thenReturn(TvShowTopRatedEmpty());

    await tester.pumpWidget(_createTestableWidget(const TvShowPage()));

    expect(find.byKey(const Key('empty_message')), findsNWidgets(3));
  });

  testWidgets('Tapping on see more (popular) should go to popular page',
      (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowOnAirHasData(testTvShowList));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(TvShowPopularHasData(testTvShowList));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TvShowTopRatedHasData(testTvShowList));

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
    expect(find.byKey(const Key('tv_show_page')), findsOneWidget);

    await tester.tap(find.byKey(const Key('see_more_popular')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_popular')), findsNothing);
    expect(find.byKey(const Key('see_more_top_rated')), findsNothing);
    expect(find.byKey(const Key('tv_show_page')), findsNothing);
  });

  testWidgets('Tapping on see more (top rated) should go to top rated page',
      (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowOnAirHasData(testTvShowList));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(TvShowPopularHasData(testTvShowList));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TvShowTopRatedHasData(testTvShowList));

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
    expect(find.byKey(const Key('tv_show_page')), findsOneWidget);

    await tester.tap(find.byKey(const Key('see_more_top_rated')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('see_more_popular')), findsNothing);
    expect(find.byKey(const Key('see_more_top_rated')), findsNothing);
    expect(find.byKey(const Key('tv_show_page')), findsNothing);
  });

  testWidgets('Tapping on on air card should go to detail page',
      (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowOnAirHasData(testTvShowList));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(TvShowPopularHasData(testTvShowList));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TvShowTopRatedHasData(testTvShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('on_air_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('tv_show_page')), findsOneWidget);

    await tester.tap(find.byKey(const Key('on_air_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('on_air_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('Tv_show_page')), findsNothing);
  });

  testWidgets('Tapping on popular card should go to detail page',
      (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowOnAirHasData(testTvShowList));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(TvShowPopularHasData(testTvShowList));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TvShowTopRatedHasData(testTvShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('on_air_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('tv_show_page')), findsOneWidget);

    await tester.tap(find.byKey(const Key('popular_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('on_air_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('tv_show_page')), findsNothing);
  });

  testWidgets('Tapping on top rated card should go to detail page',
      (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowOnAirHasData(testTvShowList));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(TvShowPopularHasData(testTvShowList));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TvShowTopRatedHasData(testTvShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('on_air_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_0')), findsOneWidget);
    expect(find.byKey(const Key('tv_show_page')), findsOneWidget);

    await tester.dragUntilVisible(
      find.byKey(const Key('top_rated_0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('top_rated_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('on_air_0')), findsNothing);
    expect(find.byKey(const Key('popular_0')), findsNothing);
    expect(find.byKey(const Key('top_rated_0')), findsNothing);
    expect(find.byKey(const Key('tv_show_page')), findsNothing);
  });

  testWidgets('Tapping search icon should go to search page', (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowOnAirHasData(testTvShowList));
    when(() => fakePopularTvShowBloc.state)
        .thenReturn(TvShowPopularHasData(testTvShowList));
    when(() => fakeTopRatedTvShowBloc.state)
        .thenReturn(TvShowTopRatedHasData(testTvShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byKey(const Key('tv_show_page')), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('tv_show_page')), findsNothing);
  });
}
