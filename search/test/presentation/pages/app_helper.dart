import 'package:flutter/material.dart';

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

class FakeDestinationPage extends StatelessWidget {
  const FakeDestinationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        key: const ValueKey('fakeDestinationPage'),
        onTap: () {
          Navigator.pop(context);
        },
        title: const Text('fake Destination Page'),
        leading: const Icon(Icons.check),
      ),
    );
  }
}
