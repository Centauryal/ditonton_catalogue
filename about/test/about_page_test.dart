import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeHomePage extends StatelessWidget {
  const FakeHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        key: const ValueKey('fakeHomePage'),
        onTap: () {
          Navigator.pushNamed(context, '/next');
        },
      ),
      appBar: AppBar(
        title: const Text('fakeHomePage'),
        leading: const Icon(Icons.menu),
      ),
    );
  }
}

void main() {
  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) => const AboutPage(),
  };

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('should render page and go back when menu tapped',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));
    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(seconds: 1));

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
    expect(find.byKey(const Key('fakeHomePage')), findsNothing);

    await tester.tap(find.byType(IconButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump(const Duration(seconds: 1));
    expect(imageFinder, findsNothing);
  });
}
