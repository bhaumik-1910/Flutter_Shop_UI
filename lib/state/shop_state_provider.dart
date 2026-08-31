import 'package:flutter/material.dart';
import 'shop_state_controller.dart';

/// InheritedNotifier to provide ShopStateController down the widget tree.
class ShopStateProvider extends InheritedNotifier<ShopStateController> {
  const ShopStateProvider({
    super.key,
    required ShopStateController controller,
    required super.child,
  }) : super(notifier: controller);

  static ShopStateController of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<ShopStateProvider>()!
          .notifier!;
    } else {
      return context
          .getInheritedWidgetOfExactType<ShopStateProvider>()!
          .notifier!;
    }
  }
}

extension ShopStateContextExtension on BuildContext {
  ShopStateController get shopState => ShopStateProvider.of(this, listen: true);
  ShopStateController get shopStateRead =>
      ShopStateProvider.of(this, listen: false);
}
