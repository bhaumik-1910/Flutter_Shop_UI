import 'package:flutter_test/flutter_test.dart';
import 'package:shop_ui/main.dart';
import 'package:shop_ui/models/coffee_item.dart';
import 'package:shop_ui/state/shop_state_controller.dart';

void main() {
  group('Shop State Unit Tests', () {
    late ShopStateController controller;

    setUp(() {
      controller = ShopStateController();
    });

    test('Initial catalog and favorites state', () {
      expect(controller.filteredCoffees.isNotEmpty, true);
      expect(controller.favoriteCount, greaterThan(0));
    });

    test('Add item to cart and calculate price', () {
      final coffee = CoffeeItem.catalog.first;
      final initialCount = controller.totalCartItemsCount;

      controller.addToCart(coffee, size: CupSize.large, quantity: 2);
      expect(controller.totalCartItemsCount, initialCount + 2);
      expect(controller.subtotalPrice, greaterThan(0));
    });

    test('Apply promo code COFFEE20 gives 20% discount', () {
      final success = controller.applyPromoCode('COFFEE20');
      expect(success, true);
      expect(controller.promoDiscountPercent, 0.20);
      expect(controller.discountAmount, greaterThan(0));
    });

    test('Toggle favorites', () {
      const coffeeId = 'black_coffee_1';
      final initialFav = controller.isFavorite(coffeeId);
      controller.toggleFavorite(coffeeId);
      expect(controller.isFavorite(coffeeId), !initialFav);
    });
  });

  testWidgets('Welcome Screen Smoke Test', (WidgetTester tester) async {
    final controller = ShopStateController();
    await tester.pumpWidget(MyApp(controller: controller));

    // Verify Coffee Shop title and Get Started CTA exist
    expect(find.text('Coffee Shop'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
