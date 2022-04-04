import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final String routes;
  final Widget content;

  const CustomDrawer({
    Key? key,
    required this.routes,
    required this.content,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double slide = 250.0 * _animationController.value;

          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()..translate(slide),
                alignment: Alignment.centerLeft,
                child: widget.content,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/circle-g.png'),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@centaury.com'),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Movies'),
          onTap: () {
            if (widget.routes != homeRoute) {
              Navigator.pushNamed(context, homeRoute);
              toggle();
            } else {
              toggle();
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.tv),
          title: const Text('TV Series'),
          onTap: () {
            if (widget.routes != tvShowRoute) {
              Navigator.pushNamed(context, tvShowRoute);
              toggle();
            } else {
              toggle();
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist'),
          onTap: () {
            if (widget.routes != watchlistRoute) {
              Navigator.pushNamed(context, watchlistRoute);
              toggle();
            } else {
              toggle();
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
          onTap: () {
            if (widget.routes != aboutRoute) {
              Navigator.pushNamed(context, aboutRoute);
              toggle();
            } else {
              toggle();
            }
          },
        ),
      ],
    );
  }
}
