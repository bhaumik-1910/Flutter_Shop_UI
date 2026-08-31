import 'package:flutter/material.dart';
import 'custom_bottom_nav_bar.dart';

/// Backward-compatible wrapper for the floating navigation bar.
class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomBottomNavBar();
  }
}
