import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mojtrsat/providers/auth_providers.dart';
import 'package:mojtrsat/views/screens/login_and_registration/login_screen.dart';
import 'package:mojtrsat/views/widgets/bottom_nav_bar.dart';

class UserSession extends ConsumerWidget {
  const UserSession({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);

   final Widget screen = session == null
        ?  LoginScreen()
        :  BottomNavigation();

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: screen.animate().fadeIn(duration: const Duration(milliseconds: 300)).slideX(begin: 1.0),
        );

   
  }
}
