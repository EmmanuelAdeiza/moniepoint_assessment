import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeBottomBar extends StatefulWidget {
  final Animation<double> animation;
  final ValueChanged<int> onPageChanged;
  final int currentIndex;

  const HomeBottomBar({
    super.key,
    required this.animation,
    required this.onPageChanged,
    required this.currentIndex,
  });

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  final List<GlobalKey> _keys = List.generate(5, (index) => GlobalKey());

  void _onItemTapped(int index) {
    if (widget.currentIndex == index) return;
    widget.onPageChanged(index);
    _showBubbleAnimation(index);
  }

  void _showBubbleAnimation(int index) {
    final RenderBox box = _keys[index].currentContext?.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);
    final size = box.size;

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) {
            return Container(
              width: size.width * (1 + value * 0.5),
              height: size.height * (1 + value * 0.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.orange.withOpacity(0.2 * (1 - value)),
              ),
            );
          },
          onEnd: () => entry.remove(),
        ),
      ),
    );

    Overlay.of(context).insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, -widget.animation.value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.backgroundGrey,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomBarItem(
                key: _keys[0],
                icon: Icons.search_rounded,
                isSelected: widget.currentIndex == 0,
                onTap: () => _onItemTapped(0),
              ),
              _BottomBarItem(
                key: _keys[1],
                icon: Icons.chat_bubble_rounded,
                isSelected: widget.currentIndex == 1,
                onTap: () => _onItemTapped(1),
              ),
              _BottomBarItem(
                key: _keys[2],
                icon: Icons.home_rounded,
                isSelected: widget.currentIndex == 2,
                onTap: () => _onItemTapped(2),
              ),
              _BottomBarItem(
                key: _keys[3],
                icon: Icons.favorite_rounded,
                isSelected: widget.currentIndex == 3,
                onTap: () => _onItemTapped(3),
              ),
              _BottomBarItem(
                key: _keys[4],
                icon: Icons.person_rounded,
                isSelected: widget.currentIndex == 4,
                onTap: () => _onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 3600.ms).slideY(begin: 2, end: 0, delay: 3600.ms);
  }
}

class _BottomBarItem extends StatefulWidget {
  const _BottomBarItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_BottomBarItem> createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<_BottomBarItem> with SingleTickerProviderStateMixin {
  bool _showRipple = false;
  late AnimationController _rippleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scale2Animation;
  late Animation<double> _opacity2Animation;
  late Animation<double> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.8,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.5,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ));

    _scale2Animation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: const Interval(0.1, 1.0, curve: Curves.easeOut),
    ));

    _opacity2Animation = Tween<double>(
      begin: 0.5,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: const Interval(0.1, 1.0, curve: Curves.easeOut),
    ));

    _colorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));
  }

  @override
  void dispose() {
    _rippleController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_BottomBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && _showRipple) {
      // Cancel the ripple animation if this item becomes selected
      setState(() {
        _showRipple = false;
      });
      _rippleController.reset();
    }
  }

  void _handleTap() {
    if (widget.isSelected) return;

    // Call onTap immediately before starting the animation
    widget.onTap();

    setState(() {
      _showRipple = true;
    });

    _rippleController.forward(from: 0.0).then((_) {
      if (!mounted) return;
      setState(() {
        _showRipple = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_showRipple && !widget.isSelected)
          AnimatedBuilder(
            animation: _rippleController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.grey.withOpacity(_opacityAnimation.value),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: _scale2Animation.value,
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.grey.withOpacity(_opacity2Animation.value),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _handleTap,
            customBorder: const CircleBorder(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.isSelected ? AppTheme.orange : AppTheme.darkerGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.icon,
                color: AppTheme.white,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
