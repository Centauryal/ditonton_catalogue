import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      key: ValueKey('home_page'),
      child: CustomDrawer(
        routes: homeRoute,
        content: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Ditonton'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, searchRoute, arguments: false);
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: MoviePage(),
        ),
      ),
    );
  }
}
