import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'screen/welcome_screen.dart';
import 'state/shop_state_controller.dart';
import 'state/shop_state_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  final shopStateController = ShopStateController();

  runApp(
    MyApp(controller: shopStateController),
  );
}

class MyApp extends StatelessWidget {
  final ShopStateController controller;

  const MyApp({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ShopStateProvider(
      controller: controller,
      child: MaterialApp(
        title: 'Artisan Coffee Shop',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const WelcomeScreen(),
      ),
    );
  }
}
