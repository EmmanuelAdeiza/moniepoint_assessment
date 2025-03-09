import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moniepoint_assessment/features/home/presentation/components/home_bottom_bar.dart';
import 'package:moniepoint_assessment/features/home/presentation/pages/favorites_page.dart';
import 'package:moniepoint_assessment/features/home/presentation/pages/messages_page.dart';
import 'package:moniepoint_assessment/features/home/presentation/pages/home_page.dart';
import 'package:moniepoint_assessment/features/home/presentation/pages/profile_page.dart';
// import 'package:moniepoint_assessment/features/search/presentation/pages/search_page.dart';
import 'package:moniepoint_assessment/features/search/presentation/screens/search_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _bottomBarAnimation;
  int _currentIndex = 2; // Default to home tab (center)

  final List<Widget> _pages = [
    const SearchPage(key: ValueKey('search')), // Search/Map tab
    const MessagesPage(key: ValueKey('messages')), // Messages/Chat tab
    const HomePage(key: ValueKey('home')), // Home tab (center)
    const FavoritesPage(key: ValueKey('favorites')), // Favorites tab (placeholder)
    const ProfilePage(key: ValueKey('profile')), // Profile tab
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _bottomBarAnimation = Tween<double>(
      begin: -80,
      end: 24,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return WillPopScope(
      onWillPop: () async {
        if (location != '/') {
          context.go('/');
          return false;
        }
        if (_currentIndex != 2) {
          setState(() => _currentIndex = 2);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Main content
            IndexedStack(
              key: ValueKey('stack_$_currentIndex'),
              index: _currentIndex,
              children: _pages,
            ),
            // Bottom navigation bar - always visible and hovering
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: HomeBottomBar(
                  animation: _bottomBarAnimation,
                  onPageChanged: _onPageChanged,
                  currentIndex: _currentIndex,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
