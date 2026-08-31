import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../screen/home_screen.dart';
import '../state/shop_state_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.shopState;

    const screens = [
      HomeScreen(),
      FavoritesScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Indexed Stack to preserve screen states
          IndexedStack(
            index: state.currentNavIndex,
            children: screens,
          ),

          // Floating Glassmorphic Bottom Navigation Bar
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavBar(),
          ),
        ],
      ),
    );
  }
}
