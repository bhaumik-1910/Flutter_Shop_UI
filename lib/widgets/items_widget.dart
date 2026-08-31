import 'package:flutter/material.dart';
import '../state/shop_state_provider.dart';
import 'coffee_card.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.shopState;
    final coffees = state.filteredCoffees;

    if (coffees.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              const Icon(
                Icons.coffee_maker_outlined,
                size: 56,
                color: Colors.white30,
              ),
              const SizedBox(height: 12),
              const Text(
                'No matching brews found',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Try searching for another coffee or reset filter',
                style: TextStyle(color: Colors.white38, fontSize: 13),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => state.clearSearch(),
                child: const Text('Reset Search'),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemCount: coffees.length,
      itemBuilder: (context, index) {
        final coffee = coffees[index];
        return CoffeeCard(coffee: coffee);
      },
    );
  }
}
