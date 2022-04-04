import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'app_helper.dart';
import 'helper/fake_pages_helper.dart';

void main() {
  late FakeMovieDetailBloc fakeMovieBloc;
  late FakeWatchlistMovieBloc fakeWatchlistBloc;
  late FakeMovieRecommendationBloc fakeRecommendationBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    fakeMovieBloc = FakeMovieDetailBloc();

    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
    fakeWatchlistBloc = FakeWatchlistMovieBloc();

    registerFallbackValue(FakeMovieRecommendationEvent());
    registerFallbackValue(FakeMovieRecommendationState());
    fakeRecommendationBloc = FakeMovieRecommendationBloc();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => fakeMovieBloc,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<MovieRecommendationBloc>(
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
        BlocProvider<MovieDetailBloc>(
          create: (context) => fakeMovieBloc,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (context) => fakeRecommendationBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) => _createAnotherTestableWidget(const MovieDetailPage(
          id: 1,
        )),
    movieDetailRoute: (context) => const FakeDestinationPage(),
  };

  testWidgets('should show circular progress when movie detail is loading',
      (tester) async {
    when(() => fakeMovieBloc.state).thenReturn(MovieDetailLoading());
    when(() => fakeRecommendationBloc.state)
        .thenReturn(MovieRecommendationLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error message progress when movie detail is error',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(const MovieDetailError('Failed'));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(MovieRecommendationLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });

  testWidgets('should show empty message progress when movie detail is empty',
      (tester) async {
    when(() => fakeMovieBloc.state).thenReturn(MovieDetailEmpty());
    when(() => fakeRecommendationBloc.state)
        .thenReturn(MovieRecommendationLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byKey(const Key('empty_message')), findsOneWidget);
  });

  testWidgets(
      'watchlist buton should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
        _createTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'watchlist buton should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(
        _createTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('watchlist buton should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        _createTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'watchlist buton should display Snackbar when remove from watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(true));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
        _createTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'should show circular progress when movie recommendation is loading',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(MovieRecommendationLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
  });

  testWidgets(
      'should show ListView ClipRReact when movie recommendation is has data',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
  });

  testWidgets('should show error text when movie recommendation is error',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(const MovieRecommendationError('Failed'));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byKey(const Key('error')), findsOneWidget);
  });

  testWidgets('should show container when movie recommendation is empty',
      (tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(MovieRecommendationEmpty());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(false));

    await tester.pumpWidget(
        _createTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byKey(const Key('empty')), findsOneWidget);
  });

  testWidgets('should back to previous page when arrow back icon was clicked',
      (WidgetTester tester) async {
    when(() => fakeMovieBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => fakeWatchlistBloc.state)
        .thenReturn(const MovieIsAddedWatchlist(false));

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
