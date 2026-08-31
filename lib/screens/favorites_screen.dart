import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/snackbar_helper.dart';
import '../screen/single_item_screen.dart';
import '../state/shop_state_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.shopState;
    final favCoffees = state.favoriteCoffees;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Saved Coffees',
          style: AppTypography.headingMedium(fontSize: 20),
        ),
      ),
      body: favCoffees.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.cardSurface,
                        border: Border.all(
                            color: AppColors.borderLight, width: 1.5),
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        size: 60,
                        color: AppColors.heartRed,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'No Favorites Yet',
                      style: AppTypography.headingMedium(fontSize: 22),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the heart icon on any coffee roast to keep your favorite brews here for quick ordering.',
                      textAlign: TextAlign.center,
                      style: AppTypography.subtitle(
                        color: AppColors.textMuted,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.shopStateRead.setNavIndex(0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Browse Coffees',
                        style: AppTypography.button(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              itemCount: favCoffees.length,
              itemBuilder: (context, index) {
                final coffee = favCoffees[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleItemScreen(coffee: coffee),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cardSurface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.borderSubtle,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Image Thumbnail with Hero
                        Container(
                          width: 80,
                          height: 80,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Hero(
                            tag: 'coffee_hero_${coffee.id}',
                            child: Image.asset(
                              coffee.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Title, rating & price
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    coffee.name,
                                    style: AppTypography.headingSmall(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        state.toggleFavorite(coffee.id),
                                    child: const Icon(
                                      Icons.favorite_rounded,
                                      color: AppColors.heartRed,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: AppColors.goldStar,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${coffee.rating} (${coffee.reviewCount} reviews)',
                                    style: AppTypography.caption(
                                      color: AppColors.textMuted,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${coffee.basePrice.toStringAsFixed(2)}',
                                    style: AppTypography.price(
                                      fontSize: 17,
                                      color: AppColors.primaryLight,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      state.addToCart(coffee);
                                      SnackbarHelper.showSuccess(
                                        context,
                                        message: '${coffee.name} added to cart',
                                        actionLabel: 'VIEW',
                                        onAction: () => state.setNavIndex(2),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.add_shopping_cart_rounded,
                                      size: 16,
                                    ),
                                    label: const Text('Add'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
