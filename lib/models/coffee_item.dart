enum CoffeeCategory {
  all,
  hotCoffee,
  coldCoffee,
  cappuccino,
  espresso,
  specialty,
}

enum CupSize {
  small,
  medium,
  large,
}

extension CupSizeExtension on CupSize {
  String get label {
    switch (this) {
      case CupSize.small:
        return 'S';
      case CupSize.medium:
        return 'M';
      case CupSize.large:
        return 'L';
    }
  }

  String get volume {
    switch (this) {
      case CupSize.small:
        return '250 ml';
      case CupSize.medium:
        return '350 ml';
      case CupSize.large:
        return '450 ml';
    }
  }

  double get extraPrice {
    switch (this) {
      case CupSize.small:
        return 0.0;
      case CupSize.medium:
        return 1.50;
      case CupSize.large:
        return 3.00;
    }
  }
}

class CoffeeItem {
  final String id;
  final String name;
  final String subtitle;
  final String description;
  final double basePrice;
  final double rating;
  final int reviewCount;
  final String imagePath;
  final CoffeeCategory category;
  final String roastLevel;
  final String origin;
  final bool isPopular;
  final List<String> flavorNotes;

  const CoffeeItem({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.basePrice,
    required this.rating,
    required this.reviewCount,
    required this.imagePath,
    required this.category,
    required this.roastLevel,
    required this.origin,
    this.isPopular = false,
    this.flavorNotes = const ['Rich Crema', 'Aromatic', 'Smooth'],
  });

  /// Mock Catalog of Premium Coffees
  static const List<CoffeeItem> catalog = [
    CoffeeItem(
      id: 'latte_1',
      name: 'Latte',
      subtitle: 'With Steamed Oat Milk & Silky Foam',
      description:
          'Our signature Latte combines rich espresso with perfectly steamed textured milk, finished with an exquisite layer of velvety micro-foam and subtle caramel notes.',
      basePrice: 4.80,
      rating: 4.9,
      reviewCount: 328,
      imagePath: 'images/Latte.png',
      category: CoffeeCategory.hotCoffee,
      roastLevel: 'Medium Roast',
      origin: 'Ethiopian Highlands',
      isPopular: true,
      flavorNotes: ['Silky Foam', 'Sweet Caramel', 'Oat Infused'],
    ),
    CoffeeItem(
      id: 'espresso_1',
      name: 'Espresso',
      subtitle: 'Pure Double Shot Arabica Extract',
      description:
          'Intense, concentrated, and crowned with a thick golden-hazelnut crema. Single-origin Arabica beans roasted to perfection for an invigorating aroma.',
      basePrice: 3.50,
      rating: 4.8,
      reviewCount: 215,
      imagePath: 'images/Espresso.png',
      category: CoffeeCategory.espresso,
      roastLevel: 'Dark Roast',
      origin: 'Colombian Andes',
      isPopular: true,
      flavorNotes: ['Dark Cocoa', 'Toasted Nut', 'Golden Crema'],
    ),
    CoffeeItem(
      id: 'cold_coffee_1',
      name: 'Cold Coffee',
      subtitle: 'Slow Steeping Nitro Cold Brew',
      description:
          'Steeped for 18 hours in filtered cold water. Extra smooth, low acidity, served chilled over artisanal crystal ice spheres with a hint of vanilla.',
      basePrice: 5.20,
      rating: 4.9,
      reviewCount: 412,
      imagePath: 'images/Cold Coffee.png',
      category: CoffeeCategory.coldCoffee,
      roastLevel: 'Medium Dark',
      origin: 'Guatemala Antigua',
      isPopular: true,
      flavorNotes: ['Vanilla Pod', 'Crisp Ice', 'Low Acidity'],
    ),
    CoffeeItem(
      id: 'black_coffee_1',
      name: 'Black Coffee',
      subtitle: 'Pour-Over Americano Blend',
      description:
          'Bold and revitalizing. Handcrafted single-origin pour-over highlighting bright floral notes, clean citrus finish, and zero sugar.',
      basePrice: 3.90,
      rating: 4.7,
      reviewCount: 184,
      imagePath: 'images/Black Coffee.png',
      category: CoffeeCategory.hotCoffee,
      roastLevel: 'Medium Roast',
      origin: 'Costa Rican Tarrazú',
      isPopular: false,
      flavorNotes: ['Citrus Bloom', 'Dark Berry', 'Clean Finish'],
    ),
    CoffeeItem(
      id: 'cappuccino_1',
      name: 'Cappuccino',
      subtitle: 'Equal Parts Espresso, Milk & Airy Froth',
      description:
          'A classic Italian ratio of bold espresso, sweet steamed milk, and a dense, pillow-like dome of froth dusted with fine Dutch cocoa powder.',
      basePrice: 4.90,
      rating: 4.85,
      reviewCount: 290,
      imagePath: 'images/Latte.png',
      category: CoffeeCategory.cappuccino,
      roastLevel: 'Medium Dark',
      origin: 'Sumatra Mandheling',
      isPopular: true,
      flavorNotes: ['Airy Froth', 'Dutch Cocoa', 'Balanced Body'],
    ),
    CoffeeItem(
      id: 'iced_caramel_latte',
      name: 'Iced Caramel Latte',
      subtitle: 'Chilled Espresso & Salted Caramel Drizzle',
      description:
          'A refreshing indulgence featuring chilled double espresso, sweet whole milk, and house-made sea-salt caramel syrup over crushed ice.',
      basePrice: 5.50,
      rating: 4.95,
      reviewCount: 520,
      imagePath: 'images/Cold Coffee.png',
      category: CoffeeCategory.coldCoffee,
      roastLevel: 'Medium Roast',
      origin: 'Brazilian Santos',
      isPopular: true,
      flavorNotes: ['Salted Caramel', 'Creamy', 'Chilled Delight'],
    ),
  ];
}
