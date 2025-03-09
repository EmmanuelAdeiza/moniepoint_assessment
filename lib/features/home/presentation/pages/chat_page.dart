import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/core/theme/app_theme.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Text('Chat Page'),
      ),
    );
  }
}
