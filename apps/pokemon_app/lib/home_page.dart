import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

class _HomeTab {
  const _HomeTab({
    required this.route,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String route;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<_HomeTab> _tabs = [
    _HomeTab(
      route: '/pokemon/',
      label: 'Pokédex',
      icon: Icons.catching_pokemon_outlined,
      selectedIcon: Icons.catching_pokemon,
    ),
    _HomeTab(
      route: '/pokemon/resources',
      label: 'Resources',
      icon: Icons.auto_stories_outlined,
      selectedIcon: Icons.auto_stories,
    ),
    _HomeTab(
      route: '/berries/',
      label: 'Berries',
      icon: Icons.egg_alt_outlined,
      selectedIcon: Icons.egg_alt,
    ),
    _HomeTab(
      route: '/items/',
      label: 'Items',
      icon: Icons.category_outlined,
      selectedIcon: Icons.category,
    ),
  ];

  int _selectedIndex = 0;

  bool _requestedDefaultTab = false;

  @override
  void initState() {
    super.initState();

    Modular.to.addListener(_syncSelection);
    _syncSelection();
  }

  @override
  void dispose() {
    Modular.to.removeListener(_syncSelection);
    super.dispose();
  }

  void _syncSelection() {
    final path = Modular.to.path;
    if (!_tabOwns(path)) {
      _requestDefaultTab();
      return;
    }
    final index = _indexForPath(path);
    if (index != _selectedIndex && mounted) {
      setState(() => _selectedIndex = index);
    }
  }

  static bool _tabOwns(String path) =>
      _tabs.any((tab) => _covers(path, tab.route));

  static int _indexForPath(String path) {
    var index = 0;
    var bestLength = -1;
    for (var i = 0; i < _tabs.length; i++) {
      final route = _tabs[i].route;
      if (route.length > bestLength && _covers(path, route)) {
        bestLength = route.length;
        index = i;
      }
    }
    return index;
  }

  static bool _covers(String path, String route) {
    final prefix = route.endsWith('/') ? route : '$route/';
    return path == route || path.startsWith(prefix);
  }

  void _requestDefaultTab() {
    if (_requestedDefaultTab) {
      return;
    }
    _requestedDefaultTab = true;
    unawaited(Modular.to.pushNamed(_tabs.first.route));
  }

  void _onDestinationSelected(int index) {
    final route = _tabs[index].route;
    setState(() => _selectedIndex = index);
    Modular.to.navigate(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: [
          for (final tab in _tabs)
            NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.selectedIcon),
              label: tab.label,
            ),
        ],
      ),
    );
  }
}
