import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';
import 'package:moniepoint_assessment/features/home/presentation/providers/property_state.dart';
import 'package:moniepoint_assessment/features/home/presentation/components/property_statistics_view.dart';
import 'package:moniepoint_assessment/features/home/presentation/pages/map_view_page.dart';
import 'package:moniepoint_assessment/features/home/presentation/components/home_header.dart';
import 'package:moniepoint_assessment/features/home/presentation/components/welcome_section.dart';
import 'package:moniepoint_assessment/features/home/presentation/components/property_list_section.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _numberAnimation;
  final ScrollController _scrollController = ScrollController();
  final double _buttonsOpacity = 1.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _numberAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _scrollController.addListener(_onScroll);

    Future.delayed(1600.ms, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final propertyState = ref.watch(propertyStateProvider);

    if (propertyState.isMapView) {
      return const MapViewPage();
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) => false,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppTheme.homeGradient,
          ),
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                CustomScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    // Fixed header content
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HomeHeader(),
                            const SizedBox(height: 36),
                            const WelcomeSection(),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) => FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                              child: _buttonsOpacity > 0.1
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 32),
                                      child: PropertyStatisticsView(
                                        key: const ValueKey('stats'),
                                        animation: _numberAnimation,
                                        opacity: _buttonsOpacity,
                                        propertyState: propertyState,
                                      ),
                                    )
                                      .animate()
                                      .fadeIn(
                                        duration: 600.ms,
                                        delay: 1600.ms,
                                      )
                                      .slideY(
                                        begin: 0.2,
                                        end: 0,
                                        curve: Curves.easeOutCubic,
                                        duration: 600.ms,
                                        delay: 1200.ms,
                                      )
                                  : const SizedBox.shrink(key: ValueKey('empty')),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned.fill(
                  top: 250,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          color: !_scrollController.hasClients
                              ? Colors.transparent
                              : _scrollController.hasClients && _scrollController.offset < 250
                                  ? Colors.transparent
                                  : AppTheme.cardBackground,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: PropertyListSection(propertyState: propertyState, scrollController: _scrollController)),
                  ),
                ).animate().moveY(
                      duration: 1600.ms,
                      delay: 2800.ms,
                      begin: MediaQuery.of(context).size.height,
                      end: 0,
                      curve: Curves.easeOutCubic,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
