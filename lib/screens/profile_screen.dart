import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/snackbar_helper.dart';
import '../state/shop_state_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.shopState;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Coffee Profile',
          style: AppTypography.headingMedium(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white70),
            onPressed: () {
              SnackbarHelper.showInfo(context, message: 'Settings opened');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // Profile Header
          _buildUserHeader(),
          const SizedBox(height: 20),

          // Loyalty Rewards Stamp Card
          _buildLoyaltyCard(context, state.loyaltyStamps),
          const SizedBox(height: 20),

          // Active Order Status Tracker
          _buildActiveOrderTracker(context, state.isBrewingOrder),
          const SizedBox(height: 20),

          // Stats Overview
          _buildStatsRow(state.ordersCompletedCount, state.favoriteCount),
          const SizedBox(height: 24),

          // Preferences & Quick Options
          _buildPreferencesCard(context),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              border: Border.all(color: AppColors.primaryLight, width: 2),
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 38,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alex Sterling',
                  style: AppTypography.headingSmall(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'alex.coffee@artisan.io',
                  style: AppTypography.caption(color: AppColors.textMuted, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    '☕ Master Connoisseur • Gold Member',
                    style: AppTypography.caption(
                      color: AppColors.primaryLight,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoyaltyCard(BuildContext context, int stamps) {
    const int totalStamps = 6;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF2C1910), Color(0xFF1E140F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.4), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Coffee Loyalty Stamp Card',
                style: AppTypography.headingSmall(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$stamps / $totalStamps Cups',
                  style: AppTypography.caption(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            stamps >= totalStamps
                ? '🎉 Congratulations! You have a Free Specialty Coffee ready!'
                : 'Collect ${totalStamps - stamps} more stamps to claim a Free Caramel Latte!',
            style: AppTypography.caption(color: AppColors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalStamps, (index) {
              final isFilled = index < stamps;
              final isReward = index == totalStamps - 1;

              return Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isFilled
                      ? AppColors.primary
                      : AppColors.cardSurface.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isFilled ? AppColors.primaryLight : AppColors.borderLight,
                    width: isReward ? 2 : 1,
                  ),
                  boxShadow: isFilled
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  isReward
                      ? (isFilled ? Icons.card_giftcard_rounded : Icons.star_rounded)
                      : (isFilled ? Icons.local_cafe_rounded : Icons.local_cafe_outlined),
                  color: isFilled ? Colors.white : Colors.white24,
                  size: 20,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveOrderTracker(BuildContext context, bool isBrewing) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Order Status',
                style: AppTypography.headingSmall(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isBrewing
                      ? AppColors.primary.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isBrewing ? AppColors.primary : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isBrewing ? 'Grinding & Brewing' : 'No Active Order',
                      style: AppTypography.caption(
                        color: isBrewing ? AppColors.primaryLight : AppColors.textMuted,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildTimelineStep('1. Received', isCompleted: true),
              _buildTimelineDivider(isCompleted: isBrewing),
              _buildTimelineStep('2. Brewing', isCompleted: isBrewing, isActive: isBrewing),
              _buildTimelineDivider(isCompleted: false),
              _buildTimelineStep('3. Ready', isCompleted: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(String label, {bool isCompleted = false, bool isActive = false}) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? AppColors.primary
                : (isActive ? AppColors.primaryLight : AppColors.surfaceDark),
            border: Border.all(
              color: isCompleted || isActive ? AppColors.primary : AppColors.borderLight,
            ),
          ),
          child: Icon(
            isCompleted ? Icons.check : Icons.circle,
            color: Colors.white,
            size: isCompleted ? 16 : 8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: AppTypography.caption(
            fontSize: 10,
            color: isCompleted || isActive ? Colors.white : AppColors.textMuted,
            fontWeight: isCompleted || isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineDivider({bool isCompleted = false}) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20),
        color: isCompleted ? AppColors.primary : AppColors.borderLight,
      ),
    );
  }

  Widget _buildStatsRow(int totalOrders, int totalSaved) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem('Orders Completed', '$totalOrders', Icons.receipt_long_rounded),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _buildStatItem('Saved Roasts', '$totalSaved', Icons.favorite_rounded),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String count, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryLight, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(count, style: AppTypography.headingSmall(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(label, style: AppTypography.caption(color: AppColors.textMuted, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        children: [
          _buildOptionTile(
            Icons.coffee_maker_rounded,
            'Brewing Preferences',
            'Oat Milk, Medium Roast, 50% Sugar',
            () => SnackbarHelper.showInfo(context, message: 'Preferences updated'),
          ),
          const Divider(color: AppColors.divider, height: 1),
          _buildOptionTile(
            Icons.location_on_outlined,
            'Favorite Pickup Spot',
            'Downtown Artisan Roastery #04',
            () => SnackbarHelper.showInfo(context, message: 'Pickup location selected'),
          ),
          const Divider(color: AppColors.divider, height: 1),
          _buildOptionTile(
            Icons.credit_card_rounded,
            'Payment Methods',
            'Apple Pay / •••• 4829',
            () => SnackbarHelper.showInfo(context, message: 'Payment settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primaryLight, size: 20),
      ),
      title: Text(title, style: AppTypography.headingSmall(fontSize: 14)),
      subtitle: Text(subtitle, style: AppTypography.caption(color: AppColors.textMuted, fontSize: 12)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white30, size: 14),
      onTap: onTap,
    );
  }
}
