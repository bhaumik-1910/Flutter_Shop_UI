import 'package:flutter/material.dart';
import 'coffee_item.dart';

class CategoryTabItem {
  final CoffeeCategory category;
  final String title;
  final IconData icon;

  const CategoryTabItem({
    required this.category,
    required this.title,
    required this.icon,
  });

  static const List<CategoryTabItem> categories = [
    CategoryTabItem(
      category: CoffeeCategory.all,
      title: 'All Coffee',
      icon: Icons.local_cafe_rounded,
    ),
    CategoryTabItem(
      category: CoffeeCategory.hotCoffee,
      title: 'Hot Coffee',
      icon: Icons.whatshot_rounded,
    ),
    CategoryTabItem(
      category: CoffeeCategory.coldCoffee,
      title: 'Cold Brew',
      icon: Icons.ac_unit_rounded,
    ),
    CategoryTabItem(
      category: CoffeeCategory.cappuccino,
      title: 'Cappuccino',
      icon: Icons.coffee_rounded,
    ),
    CategoryTabItem(
      category: CoffeeCategory.espresso,
      title: 'Espresso',
      icon: Icons.bolt_rounded,
    ),
  ];
}
