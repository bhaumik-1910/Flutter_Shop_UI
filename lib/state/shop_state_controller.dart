import 'package:flutter/foundation.dart';
import '../models/coffee_item.dart';
import '../models/cart_item.dart';

class ShopStateController extends ChangeNotifier {
  // Navigation State
  int _currentNavIndex = 0;
  int get currentNavIndex => _currentNavIndex;

  void setNavIndex(int index) {
    if (_currentNavIndex != index) {
      _currentNavIndex = index;
      notifyListeners();
    }
  }

  // Filter & Search State
  CoffeeCategory _selectedCategory = CoffeeCategory.all;
  CoffeeCategory get selectedCategory => _selectedCategory;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void setSelectedCategory(CoffeeCategory category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  List<CoffeeItem> get filteredCoffees {
    return CoffeeItem.catalog.where((coffee) {
      // Category Match
      final matchesCategory = _selectedCategory == CoffeeCategory.all ||
          coffee.category == _selectedCategory;

      // Search Query Match
      final query = _searchQuery.trim().toLowerCase();
      final matchesQuery = query.isEmpty ||
          coffee.name.toLowerCase().contains(query) ||
          coffee.subtitle.toLowerCase().contains(query) ||
          coffee.flavorNotes.any((n) => n.toLowerCase().contains(query));

      return matchesCategory && matchesQuery;
    }).toList();
  }

  // Favorites State
  final Set<String> _favoriteCoffeeIds = {'latte_1', 'cold_coffee_1'};
  Set<String> get favoriteCoffeeIds => Set.unmodifiable(_favoriteCoffeeIds);

  bool isFavorite(String coffeeId) => _favoriteCoffeeIds.contains(coffeeId);

  void toggleFavorite(String coffeeId) {
    if (_favoriteCoffeeIds.contains(coffeeId)) {
      _favoriteCoffeeIds.remove(coffeeId);
    } else {
      _favoriteCoffeeIds.add(coffeeId);
    }
    notifyListeners();
  }

  List<CoffeeItem> get favoriteCoffees {
    return CoffeeItem.catalog
        .where((item) => _favoriteCoffeeIds.contains(item.id))
        .toList();
  }

  int get favoriteCount => _favoriteCoffeeIds.length;

  // Cart State
  final List<CartItem> _cartItems = [
    CartItem(
      id: 'cart_demo_1',
      coffee: CoffeeItem.catalog[0], // Latte
      size: CupSize.medium,
      milkOption: 'Oat Milk',
      sugarLevel: 'Regular (50%)',
      quantity: 1,
    ),
  ];
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  int get totalCartItemsCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  void addToCart(
    CoffeeItem coffee, {
    CupSize size = CupSize.medium,
    String milkOption = 'Oat Milk',
    String sugarLevel = 'Regular (50%)',
    int quantity = 1,
  }) {
    final existingIndex = _cartItems.indexWhere(
      (item) =>
          item.coffee.id == coffee.id &&
          item.size == size &&
          item.milkOption == milkOption &&
          item.sugarLevel == sugarLevel,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      final newCartItem = CartItem(
        id: 'cart_${DateTime.now().millisecondsSinceEpoch}',
        coffee: coffee,
        size: size,
        milkOption: milkOption,
        sugarLevel: sugarLevel,
        quantity: quantity,
      );
      _cartItems.add(newCartItem);
    }
    notifyListeners();
  }

  void incrementCartItem(String cartItemId) {
    final index = _cartItems.indexWhere((item) => item.id == cartItemId);
    if (index != -1) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decrementCartItem(String cartItemId) {
    final index = _cartItems.indexWhere((item) => item.id == cartItemId);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeFromCart(String cartItemId) {
    _cartItems.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _appliedPromoCode = null;
    notifyListeners();
  }

  // Promo & Price Calculations
  String? _appliedPromoCode;
  String? get appliedPromoCode => _appliedPromoCode;

  double get promoDiscountPercent {
    if (_appliedPromoCode == 'COFFEE20') return 0.20;
    if (_appliedPromoCode == 'BARISTA10') return 0.10;
    return 0.0;
  }

  bool applyPromoCode(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode == 'COFFEE20' || cleanCode == 'BARISTA10') {
      _appliedPromoCode = cleanCode;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removePromoCode() {
    _appliedPromoCode = null;
    notifyListeners();
  }

  double get subtotalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get discountAmount => subtotalPrice * promoDiscountPercent;

  double get deliveryFee {
    if (subtotalPrice == 0 || subtotalPrice > 20.0) {
      return 0.0; // Free delivery for orders > $20
    }
    return 2.50;
  }

  double get taxAmount => (subtotalPrice - discountAmount) * 0.08;

  double get grandTotalPrice {
    if (subtotalPrice == 0) return 0.0;
    return (subtotalPrice - discountAmount) + deliveryFee + taxAmount;
  }

  // Loyalty & Rewards State
  int _loyaltyStamps = 4;
  int get loyaltyStamps => _loyaltyStamps;
  static const int maxLoyaltyStamps = 6;

  int _ordersCompletedCount = 12;
  int get ordersCompletedCount => _ordersCompletedCount;

  bool _isBrewingOrder = false;
  bool get isBrewingOrder => _isBrewingOrder;

  void placeOrder() {
    if (_cartItems.isEmpty) return;
    _ordersCompletedCount++;
    _loyaltyStamps = (_loyaltyStamps + 1) % (maxLoyaltyStamps + 1);
    if (_loyaltyStamps == 0) _loyaltyStamps = 1;
    _isBrewingOrder = true;
    clearCart();
    notifyListeners();
  }
}
