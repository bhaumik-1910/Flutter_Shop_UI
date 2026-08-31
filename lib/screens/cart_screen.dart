import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/snackbar_helper.dart';
import '../state/shop_state_provider.dart';
import '../widgets/order_success_dialog.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.shopState;
    final cartItems = state.cartItems;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: AppTypography.headingMedium(fontSize: 20),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined, color: Colors.white70),
              tooltip: 'Clear Cart',
              onPressed: () {
                state.clearCart();
                SnackbarHelper.showInfo(context, message: 'Cart cleared');
              },
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart(context)
          : Column(
              children: [
                // Scrollable Items List & Promo Code
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    children: [
                      ...cartItems.map((item) => _buildCartItemCard(context, item)),
                      const SizedBox(height: 12),
                      _buildPromoSection(context),
                      const SizedBox(height: 16),
                      _buildOrderSummaryCard(context),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Bottom Sticky Checkout Bar
                _buildCheckoutBar(context),
              ],
            ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cardSurface,
                border: Border.all(color: AppColors.borderLight, width: 1.5),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 64,
                color: AppColors.primaryLight,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your Cart is Empty',
              style: AppTypography.headingMedium(fontSize: 22),
            ),
            const SizedBox(height: 10),
            Text(
              'Looks like you haven\'t added any delicious artisan coffees to your cup yet.',
              textAlign: TextAlign.center,
              style: AppTypography.subtitle(color: AppColors.textMuted, fontSize: 14),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                context.shopStateRead.setNavIndex(0);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Explore Menu',
                style: AppTypography.button(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemCard(BuildContext context, dynamic item) {
    final state = context.shopStateRead;

    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        state.removeFromCart(item.id);
        SnackbarHelper.showInfo(
          context,
          message: '${item.coffee.name} removed from cart',
        );
      },
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderSubtle, width: 1),
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
            // Thumbnail
            Container(
              width: 75,
              height: 75,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(item.coffee.imagePath, fit: BoxFit.contain),
            ),
            const SizedBox(width: 14),

            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.coffee.name,
                    style: AppTypography.headingSmall(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Size ${item.size.label} (${item.size.volume}) • ${item.milkOption}',
                    style: AppTypography.caption(color: AppColors.textMuted, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${item.totalPrice.toStringAsFixed(2)}',
                    style: AppTypography.price(fontSize: 16, color: AppColors.primaryLight),
                  ),
                ],
              ),
            ),

            // Quantity Controls Stepper
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => state.decrementCartItem(item.id),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.cardSurfaceLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.remove, size: 14, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${item.quantity}',
                      style: AppTypography.headingSmall(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => state.incrementCartItem(item.id),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoSection(BuildContext context) {
    final state = context.shopState;
    final isApplied = state.appliedPromoCode != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isApplied ? AppColors.primary.withValues(alpha: 0.5) : AppColors.borderSubtle,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.local_offer_outlined,
            color: isApplied ? AppColors.primary : AppColors.textMuted,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: isApplied
                ? Text(
                    'Coupon ${state.appliedPromoCode} (20% OFF)',
                    style: AppTypography.subtitle(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  )
                : TextField(
                    controller: _promoController,
                    style: AppTypography.body(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Enter Voucher (e.g. COFFEE20)',
                      hintStyle: AppTypography.caption(color: AppColors.textMuted),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
          ),
          if (isApplied)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white60, size: 18),
              onPressed: () => state.removePromoCode(),
            )
          else
            TextButton(
              onPressed: () {
                final applied = state.applyPromoCode(_promoController.text);
                if (applied) {
                  SnackbarHelper.showSuccess(context, message: 'Promo code applied!');
                  _promoController.clear();
                } else {
                  SnackbarHelper.showInfo(
                    context,
                    message: 'Invalid code. Try "COFFEE20"',
                  );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                'Apply',
                style: AppTypography.button(fontSize: 13, color: AppColors.primaryLight),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard(BuildContext context) {
    final state = context.shopState;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: AppTypography.headingSmall(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          _buildSummaryRow('Subtotal', '\$${state.subtotalPrice.toStringAsFixed(2)}'),
          if (state.discountAmount > 0) ...[
            const SizedBox(height: 8),
            _buildSummaryRow(
              'Discount (20%)',
              '-\$${state.discountAmount.toStringAsFixed(2)}',
              color: AppColors.success,
            ),
          ],
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Delivery Fee',
            state.deliveryFee == 0 ? 'FREE' : '\$${state.deliveryFee.toStringAsFixed(2)}',
            color: state.deliveryFee == 0 ? AppColors.success : null,
          ),
          const SizedBox(height: 8),
          _buildSummaryRow('Estimated Tax (8%)', '\$${state.taxAmount.toStringAsFixed(2)}'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.divider, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTypography.headingSmall(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${state.grandTotalPrice.toStringAsFixed(2)}',
                style: AppTypography.price(fontSize: 20, color: AppColors.primaryLight),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.caption(color: AppColors.textSecondary, fontSize: 13)),
        Text(
          value,
          style: AppTypography.caption(
            color: color ?? Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutBar(BuildContext context) {
    final state = context.shopState;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: const Border(top: BorderSide(color: AppColors.borderLight, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16,
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
              Text('Total Price', style: AppTypography.caption(color: AppColors.textMuted)),
              Text(
                '\$${state.grandTotalPrice.toStringAsFixed(2)}',
                style: AppTypography.price(fontSize: 22, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  state.placeOrder();
                  OrderSuccessDialog.show(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Checkout Now', style: AppTypography.button(fontSize: 16)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
