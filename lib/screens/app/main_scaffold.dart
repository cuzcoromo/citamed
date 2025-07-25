import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int index = _getSelectedIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => _onItemTapped(context, i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Citas',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Medicos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/citas');
        break;
      case 2:
        context.go('/medicos');
        break;
      case 3:
        context.go('/perfil');
        break;
    }
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith('/medicos') ||
        location.startsWith('/doc-info') ||
        location.startsWith('/det-cita')) {
      return 2; // Medicos
    }
    if (location.startsWith('/medicos')) return 2;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/citas')) return 1;
    if (location.startsWith('/perfil')) return 3;
    return 0;
  }
}
