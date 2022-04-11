import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/search_tv_show_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:tvshow/tvshow.dart';

import '../../dummy_data/mock_data.dart';
import 'app_helper.dart';
import 'helper/fake_search_helper.dart';

void main() {
  late FakeSearchBloc fakeMovieBloc;
  late FakeSearchTvShowBloc fakeTvShowBloc;

  setUp(() {
    registerFallbackValue(FakeSearchEvent());
    registerFallbackValue(FakeSearchState());
    fakeMovieBloc = FakeSearchBloc();

    registerFallbackValue(FakeSearchTvShowEvent());
    registerFallbackValue(FakeSearchTvShowState());
    fakeTvShowBloc = FakeSearchTvShowBloc();
  });

  tearDown(() {
    fakeMovieBloc.close();
    fakeTvShowBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (context) => fakeMovieBloc,
        ),
        BlocProvider<SearchTvShowBloc>(
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
        BlocProvider<SearchBloc>(
          create: (context) => fakeMovieBloc,
        ),
        BlocProvider<SearchTvShowBloc>(
          create: (context) => fakeTvShowBloc,
        ),
      ],
      child: body,
    );
  }

  final routesMovie = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) => _createAnotherTestableWidget(
          const SearchPage(
            isTvShow: false,
          ),
        ),
    movieDetailRoute: (context) => const FakeDestinationPage(),
    tvShowDetailRoute: (context) => const FakeDestinationPage(),
  };

  final routesTvShow = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) => _createAnotherTestableWidget(
          const SearchPage(
            isTvShow: true,
          ),
        ),
    movieDetailRoute: (context) => const FakeDestinationPage(),
    tvShowDetailRoute: (context) => const FakeDestinationPage(),
  };

  group('test for movie search', () {
    testWidgets('Page should display loading indicator when data is loading',
        (WidgetTester tester) async {
      when(() => fakeMovieBloc.state).thenReturn(SearchLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester
          .pumpWidget(_createTestableWidget(const SearchPage(isTvShow: false)));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is gotten successful',
        (WidgetTester tester) async {
      when(() => fakeMovieBloc.state).thenReturn(SearchHasData(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester
          .pumpWidget(_createTestableWidget(const SearchPage(isTvShow: false)));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets(
        'Page should display text error message when data is gotten error',
        (WidgetTester tester) async {
      when(() => fakeMovieBloc.state).thenReturn(const SearchError('Failed'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester
          .pumpWidget(_createTestableWidget(const SearchPage(isTvShow: false)));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when empty',
        (WidgetTester tester) async {
      when(() => fakeMovieBloc.state).thenReturn(SearchEmpty());

      final textFinder = find.byKey(const Key('empty_data'));

      await tester
          .pumpWidget(_createTestableWidget(const SearchPage(isTvShow: false)));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(textFinder, findsOneWidget);
    });

    testWidgets(
        'user should display Listview when data is gotten successfuk and Tapping on item go to detail page',
        (WidgetTester tester) async {
      when(() => fakeMovieBloc.state).thenReturn(SearchHasData(testMovieList));

      await tester.pumpWidget(MaterialApp(
        routes: routesMovie,
      ));

      expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

      await tester.tap(find.byKey(const Key('fakeHomePage')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('search_page')), findsOneWidget);
      expect(find.byKey(const Key('movie_card_0')), findsOneWidget);
      expect(find.byKey(const Key('movie_text_field')), findsOneWidget);

      await tester.tap(find.byKey(const Key('movie_card_0')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('search_page')), findsNothing);
      expect(find.byKey(const Key('movie_card_0')), findsNothing);
      expect(find.byKey(const Key('movie_text_field')), findsNothing);
    });
  });

  group('test for tv show search', () {
    testWidgets('Page should display loading indicator when data is loading',
        (WidgetTester tester) async {
      when(() => fakeTvShowBloc.state).thenReturn(SearchTvShowLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester
          .pumpWidget(_createTestableWidget(const SearchPage(isTvShow: true)));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is gotten successful',
        (WidgetTester tester) async {
      when(() => fakeTvShowBloc.state)
          .thenReturn(SearchTvShowHasData(testTvShowList));

      final listViewFinder = find.byType(ListView);
      final tvShowCardFinder = find.byType(TvShowCard);

      await tester
          .pumpWidget(_createTestableWidget(const SearchPage(isTvShow: true)));

      expect(tvShowCardFinder, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets(
        'Page should display text error message when data is gotten error',
        (WidgetTester tester) async {
      when(() => fakeTvShowBloc.state)
          .thenReturn(const SearchTvShowError('Failed'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester
          .pumpWidget(_createTestableWidget(const SearchPage(isTvShow: true)));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when empty',
        (WidgetTester tester) async {
      when(() => fakeTvShowBloc.state).thenReturn(SearchTvShowEmpty());

      final textFinder = find.byKey(const Key('empty_data'));

      await tester
          .pumpWidget(_createTestableWidget(const SearchPage(isTvShow: true)));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(textFinder, findsOneWidget);
    });

    testWidgets(
        'user should display Listview when data is gotten successfuk and Tapping on item go to detail page',
        (WidgetTester tester) async {
      when(() => fakeTvShowBloc.state)
          .thenReturn(SearchTvShowHasData(testTvShowList));

      await tester.pumpWidget(MaterialApp(
        routes: routesTvShow,
      ));

      expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

      await tester.tap(find.byKey(const Key('fakeHomePage')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('search_page')), findsOneWidget);
      expect(find.byKey(const Key('tv_show_card_0')), findsOneWidget);
      expect(find.byKey(const Key('tv_show_text_field')), findsOneWidget);

      await tester.tap(find.byKey(const Key('tv_show_card_0')));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(find.byKey(const Key('search_page')), findsNothing);
      expect(find.byKey(const Key('tv_show_card_0')), findsNothing);
      expect(find.byKey(const Key('tv_show_text_field')), findsNothing);
    });
  });
}
