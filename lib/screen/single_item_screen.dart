import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/snackbar_helper.dart';
import '../models/coffee_item.dart';
import '../state/shop_state_provider.dart';
import '../widgets/size_selector_widget.dart';

class SingleItemScreen extends StatefulWidget {
  final CoffeeItem? coffee;
  final String? img;

  const SingleItemScreen({
    super.key,
    this.coffee,
    this.img,
  });

  @override
  State<SingleItemScreen> createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
  late CoffeeItem _coffee;
  CupSize _selectedSize = CupSize.medium;
  String _selectedMilk = 'Oat Milk';
  String _selectedSugar = 'Regular (50%)';
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    if (widget.coffee != null) {
      _coffee = widget.coffee!;
    } else {
      // Lookup or fallback from img name
      final match = CoffeeItem.catalog.firstWhere(
        (item) =>
            item.name.toLowerCase() == (widget.img ?? '').toLowerCase() ||
            item.imagePath.contains(widget.img ?? ''),
        orElse: () => CoffeeItem.catalog.first,
      );
      _coffee = match;
    }
  }

  double get _currentUnitPrice => _coffee.basePrice + _selectedSize.extraPrice;
  double get _currentTotalPrice => _currentUnitPrice * _quantity;

  @override
  Widget build(BuildContext context) {
    final state = context.shopState;
    final isFav = state.isFavorite(_coffee.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Scrollable Content
          CustomScrollView(
            slivers: [
              // Top Hero App Bar
              SliverAppBar(
                expandedHeight: 330,
                pinned: true,
                backgroundColor: AppColors.surfaceDark,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withValues(alpha: 0.5),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withValues(alpha: 0.5),
                      child: IconButton(
                        icon: Icon(
                          isFav
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: isFav ? AppColors.heartRed : Colors.white,
                          size: 20,
                        ),
                        onPressed: () => state.toggleFavorite(_coffee.id),
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF2C241F),
                              Color(0xFF1B1613),
                              AppColors.background,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 20),
                          child: Hero(
                            tag: 'coffee_hero_${_coffee.id}',
                            child: Image.asset(
                              _coffee.imagePath,
                              height: 220,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Product Info & Customizations
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Tag & Origin
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Text(
                              _coffee.roastLevel.toUpperCase(),
                              style: AppTypography.caption(
                                color: AppColors.primaryLight,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.public_rounded,
                                  size: 14, color: AppColors.textMuted),
                              const SizedBox(width: 4),
                              Text(
                                _coffee.origin,
                                style: AppTypography.caption(
                                    color: AppColors.textMuted, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Name & Subtitle
                      Text(
                        _coffee.name,
                        style: AppTypography.headingLarge(fontSize: 28),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _coffee.subtitle,
                        style: AppTypography.subtitle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Rating & Reviews Pill
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: AppColors.goldStar, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            _coffee.rating.toStringAsFixed(1),
                            style: AppTypography.headingSmall(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(${_coffee.reviewCount} reviews)',
                            style: AppTypography.caption(
                                color: AppColors.textMuted, fontSize: 13),
                          ),
                          const Spacer(),
                          // Quantity Stepper
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.cardSurface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.borderSubtle),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_quantity > 1) {
                                      setState(() => _quantity--);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceDark,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.remove,
                                        size: 16, color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: Text(
                                    '$_quantity',
                                    style: AppTypography.headingSmall(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() => _quantity++),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.add,
                                        size: 16, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Description
                      Text(
                        'Description',
                        style: AppTypography.headingSmall(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _coffee.description,
                        style: AppTypography.body(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Flavor Notes Chips
                      Text(
                        'Flavor Profile',
                        style: AppTypography.headingSmall(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: _coffee.flavorNotes.map((note) {
                          return Chip(
                            label: Text(note),
                            backgroundColor: AppColors.cardSurface,
                            labelStyle: AppTypography.caption(
                              color: AppColors.primaryLight,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            side:
                                const BorderSide(color: AppColors.borderSubtle),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 22),

                      // Cup Size Selector
                      Text(
                        'Select Cup Size',
                        style: AppTypography.headingSmall(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      SizeSelectorWidget(
                        selectedSize: _selectedSize,
                        onSizeSelected: (size) {
                          setState(() => _selectedSize = size);
                        },
                      ),
                      const SizedBox(height: 22),

                      // Milk Choice
                      Text(
                        'Milk Preference',
                        style: AppTypography.headingSmall(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children:
                            ['Oat Milk', 'Whole Milk', 'Almond Milk', 'No Milk']
                                .map((milk) {
                          final isSelected = _selectedMilk == milk;
                          return ChoiceChip(
                            label: Text(milk),
                            selected: isSelected,
                            onSelected: (_) =>
                                setState(() => _selectedMilk = milk),
                            selectedColor: AppColors.primary,
                            backgroundColor: AppColors.cardSurface,
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                            side:
                                const BorderSide(color: AppColors.borderSubtle),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 22),

                      // Sweetness Level
                      Text(
                        'Sweetness Level',
                        style: AppTypography.headingSmall(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: [
                          'No Sugar (0%)',
                          'Regular (50%)',
                          'Sweet (100%)'
                        ].map((sugar) {
                          final isSelected = _selectedSugar == sugar;
                          return ChoiceChip(
                            label: Text(sugar),
                            selected: isSelected,
                            onSelected: (_) =>
                                setState(() => _selectedSugar = sugar),
                            selectedColor: AppColors.primary,
                            backgroundColor: AppColors.cardSurface,
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                            side:
                                const BorderSide(color: AppColors.borderSubtle),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating Bottom Sticky Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark.withValues(alpha: 0.96),
                border: const Border(
                  top: BorderSide(color: AppColors.borderLight, width: 1.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 18,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Price',
                        style: AppTypography.caption(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '\$${_currentTotalPrice.toStringAsFixed(2)}',
                        style: AppTypography.price(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          state.addToCart(
                            _coffee,
                            size: _selectedSize,
                            milkOption: _selectedMilk,
                            sugarLevel: _selectedSugar,
                            quantity: _quantity,
                          );
                          SnackbarHelper.showSuccess(
                            context,
                            message: '$_quantity x ${_coffee.name} added to cart!',
                            actionLabel: 'VIEW CART',
                            onAction: () {
                              Navigator.pop(context);
                              state.setNavIndex(2); // Go to Cart tab
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 6,
                          shadowColor:
                              AppColors.primary.withValues(alpha: 0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_bag_outlined,
                                color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Add to Cart',
                              style: AppTypography.button(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
