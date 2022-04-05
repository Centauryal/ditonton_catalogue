import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshow/tvshow.dart';

import '../../dummy_data/dummy_objects.dart';
import 'app_helper.dart';
import 'helper/fake_pages_helper.dart';

void main() {
  late FakeTvShowPopularBloc fakeTvShowBloc;

  setUp(() {
    registerFallbackValue(FakeTvShowPopularEvent());
    registerFallbackValue(FakeTvShowPopularState());
    fakeTvShowBloc = FakeTvShowPopularBloc();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<TvShowPopularBloc>(
      create: (context) => fakeTvShowBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return BlocProvider<TvShowPopularBloc>(
      create: (context) => fakeTvShowBloc,
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) =>
        _createAnotherTestableWidget(const PopularTvShowsPage()),
    tvShowDetailRoute: (context) => const FakeDestinationPage(),
  };

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeTvShowBloc.state).thenReturn(TvShowPopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_createTestableWidget(const PopularTvShowsPage()));

    expect(progressBarFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowPopularHasData(testTvShowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const PopularTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(const TvShowPopularError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_createTestableWidget(const PopularTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when empty',
      (WidgetTester tester) async {
    when(() => fakeTvShowBloc.state).thenReturn(TvShowPopularEmpty());

    final textFinder = find.byKey(const Key('empty_data'));

    await tester.pumpWidget(_createTestableWidget(const PopularTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Tapping on item should go to detail page', (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowPopularHasData(testTvShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    final tvShowCardFinder = find.byType(TvShowCard);
    expect(tvShowCardFinder, findsOneWidget);
    expect(find.byKey(const Key('tv_show_card_0')), findsOneWidget);
    expect(find.byKey(const Key('popular_tv_shows_page')), findsOneWidget);
    expect(find.byKey(const Key('fakeHomePage')), findsNothing);

    await tester.tap(find.byKey(const Key('tv_show_card_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('popular_tv_shows_page')), findsNothing);
  });
}
