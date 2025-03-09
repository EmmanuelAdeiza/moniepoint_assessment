import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.onChanged,
    this.onFilterTap,
    this.searchQuery = '',
  });

  final Function(String) onChanged;
  final VoidCallback? onFilterTap;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: AppTheme.grey,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: searchQuery)
                      ..selection = TextSelection.fromPosition(
                        TextPosition(offset: searchQuery.length),
                      ),
                    decoration: const InputDecoration(
                      hintText: 'Saint Petersburg',
                      hintStyle: TextStyle(
                        color: AppTheme.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(
                      color: AppTheme.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ).animate().scaleXY(begin: 0.1, end: 1.0, duration: 800.ms, curve: Curves.easeInOut),
        ),
        const SizedBox(width: 12),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onFilterTap,
              borderRadius: BorderRadius.circular(25),
              child: const Icon(
                Icons.tune,
                color: AppTheme.grey,
                size: 20,
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(
              duration: 400.ms,
              curve: Curves.easeOut,
            )
            .scaleXY(
              begin: 0.1,
              end: 1.0,
              duration: 800.ms,
              curve: Curves.easeIn,
            ),
      ],
    );
  }
}
