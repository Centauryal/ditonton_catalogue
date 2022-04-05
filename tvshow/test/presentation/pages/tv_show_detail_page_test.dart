import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshow/tvshow.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'app_helper.dart';
import 'helper/fake_pages_helper.dart';

void main() {
  late FakeTvShowDetailBloc fakeTvShowBloc;
  late FakeWatchlistTvShowBloc fakeWatchlistBloc;
  late FakeTvShowRecommendationBloc fakeRecommendationBloc;

  setUpAll(() {
    registerFallbackValue(FakeTvShowDetailEvent());
    registerFallbackValue(FakeTvShowDetailState());
    fakeTvShowBloc = FakeTvShowDetailBloc();

    registerFallbackValue(FakeWatchlistTvShowEvent());
    registerFallbackValue(FakeWatchlistTvShowState());
    fakeWatchlistBloc = FakeWatchlistTvShowBloc();

    registerFallbackValue(FakeTvShowRecommendationEvent());
    registerFallbackValue(FakeTvShowRecommendationState());
    fakeRecommendationBloc = FakeTvShowRecommendationBloc();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvShowDetailBloc>(
          create: (context) => fakeTvShowBloc,
        ),
        BlocProvider<WatchlistTvShowBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<TvShowRecommendationBloc>(
          create: (context) => fakeRecommendationBloc,
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
        BlocProvider<TvShowDetailBloc>(
          create: (context) => fakeTvShowBloc,
        ),
        BlocProvider<WatchlistTvShowBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<TvShowRecommendationBloc>(
          create: (context) => fakeRecommendationBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) => _createAnotherTestableWidget(const TvShowDetailPage(
          id: 1,
        )),
    tvShowDetailRoute: (context) => const FakeDestinationPage(),
  };

  testWidgets('should show circular progress when tvshow detail is loading',
      (tester) async {
    when(() => fakeTvShowBloc.state).thenReturn(TvShowDetailLoading());
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(TvShowDetailPage(id: testTvShowDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error message progress when tvshow detail is error',
      (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(const TvShowDetailError('Failed'));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(TvShowDetailPage(id: testTvShowDetail.id)));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });

  testWidgets('should show empty message progress when tvshow detail is empty',
      (tester) async {
    when(() => fakeTvShowBloc.state).thenReturn(TvShowDetailEmpty());
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(TvShowDetailPage(id: testTvShowDetail.id)));

    expect(find.byKey(const Key('empty_message')), findsOneWidget);
  });

  testWidgets(
      'watchlist button should display add icon when tvshow not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationHasData(testTvShowList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
        _createTestableWidget(TvShowDetailPage(id: testTvShowDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'watchlist button should display check icon when tvshow is added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationHasData(testTvShowList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(
        _createTestableWidget(TvShowDetailPage(id: testTvShowDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationHasData(testTvShowList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        _createTestableWidget(TvShowDetailPage(id: testTvShowDetail.id)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsNothing);
  });

  testWidgets(
      'watchlist button should display Snackbar when remove from watchlist',
      (WidgetTester tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationHasData(testTvShowList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(true));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        _createTestableWidget(TvShowDetailPage(id: testTvShowDetail.id)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsNothing);
  });

  testWidgets(
      'should show circular progress when tvshow recommendation is loading',
      (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(TvShowDetailPage(id: testTvShowDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
  });

  testWidgets(
      'should show ListView ClipRReact when tvshow recommendation is has data',
      (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationHasData(testTvShowList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(TvShowDetailPage(id: testTvShowDetail.id)));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
  });

  testWidgets('should show error text when tvshow recommendation is error',
      (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(const TvShowRecommendationError('Failed'));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(TvShowDetailPage(id: testTvShowDetail.id)));

    expect(find.byKey(const Key('error_recommendation')), findsOneWidget);
  });

  testWidgets('should show container when tvshow recommendation is empty',
      (tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationEmpty());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(TvShowDetailPage(id: testTvShowDetail.id)));

    expect(find.byKey(const Key('empty_recommendation')), findsOneWidget);
  });

  testWidgets(
      'should go to another tvshow detail when recommendation card was clicked',
      (WidgetTester tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationHasData(testTvShowList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(false));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('recommendation_0')), findsOneWidget);

    await tester.dragUntilVisible(
      find.byKey(const Key('recommendation_0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('recommendation_0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('recommendation_0')), findsNothing);
  });

  testWidgets('should back to previous page when arrow back icon was clicked',
      (WidgetTester tester) async {
    when(() => fakeTvShowBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(TvShowRecommendationHasData(testTvShowList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const TvShowIsAddedWatchlist(false));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.byKey(const Key('fakeHomePage')), findsNothing);

    await tester.tap(find.byIcon(Icons.arrow_back));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsNothing);
  });
}
