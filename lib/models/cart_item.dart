import 'coffee_item.dart';

class CartItem {
  final String id;
  final CoffeeItem coffee;
  final CupSize size;
  final String milkOption;
  final String sugarLevel;
  int quantity;

  CartItem({
    required this.id,
    required this.coffee,
    required this.size,
    this.milkOption = 'Oat Milk',
    this.sugarLevel = 'Regular (50%)',
    this.quantity = 1,
  });

  double get unitPrice => coffee.basePrice + size.extraPrice;

  double get totalPrice => unitPrice * quantity;

  CartItem copyWith({
    String? id,
    CoffeeItem? coffee,
    CupSize? size,
    String? milkOption,
    String? sugarLevel,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      coffee: coffee ?? this.coffee,
      size: size ?? this.size,
      milkOption: milkOption ?? this.milkOption,
      sugarLevel: sugarLevel ?? this.sugarLevel,
      quantity: quantity ?? this.quantity,
    );
  }
}
