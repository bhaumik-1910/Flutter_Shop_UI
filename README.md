# ☕ Artisan Coffee Shop — Flutter E-Commerce UI

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.24%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.4%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Material Design 3](https://img.shields.io/badge/Material%203-Dark%20Theme-orange?style=for-the-badge&logo=materialdesign&logoColor=white)
![Linter](https://img.shields.io/badge/dart%20analyze-0%20Issues-brightgreen?style=for-the-badge&logo=dart)
![Tests](https://img.shields.io/badge/Tests-Passing-success?style=for-the-badge&logo=githubactions)
![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)

<p align="center">
  <b>A production-grade, state-managed Specialty Coffee E-Commerce mobile application built with Flutter.</b><br>
  Features a luxury dark-espresso design system, glassmorphic UI components, smooth Hero transitions, reactive cart & checkout calculations, interactive cup customizers, and loyalty rewards tracking.
</p>

[Key Features](#-key-features) •
[App Architecture](#-project-architecture) •
[Screens & Flows](#-screens--flows) •
[Getting Started](#-getting-started) •
[Testing & Quality](#-testing--code-quality) •
[Author](#-author)

</div>

---

## 🌟 Key Features

### 🎨 **Luxury Artisanal Design System**
- **Rich Dark Theme**: Custom dark espresso palette (`#0F1012`, `#1B1D20`, `#E57734` Amber Roast, `#FFC107` Gold Star) with subtle gradients and glassmorphism.
- **Modern Typography**: Curated pairing of `GoogleFonts.pacifico` for display titles with `GoogleFonts.outfit` for sleek body & pricing hierarchy.
- **Fluid Micro-interactions**: Hero animations between catalog cards and product detail views, responsive ripple taps, and bouncing button states.
- **Floating Toast Notifications**: Custom `SnackbarHelper` providing non-intrusive floating feedback with quick action buttons (`VIEW CART`).

### ⚡ **State Management & Business Logic**
- **Reactive Cart Engine**: Full quantity stepper management (`+` / `-`), swipe-to-dismiss deletion, and live cart badge counters.
- **Dynamic Pricing Calculator**: Instant live calculation of base price + cup size extras, delivery fees (Free for orders > $20), 8% tax, and voucher discounts.
- **Promo Code System**: Interactive voucher entry supporting `COFFEE20` (20% off) and `BARISTA10` with instant price reduction and snackbar confirmation.
- **Real-Time Search & Category Filters**: Instant search across titles, subtitles, and flavor notes with clear button and filter modal sheet.
- **Favorites Management**: Instant toggle of liked brews with persistent badge state and dedicated favorites screen.
- **Coffee Loyalty Rewards**: Interactive digital stamp card tracker (*"4/6 Stamps Collected — Collect 2 more for a Free Latte!"*) and live order progression.

---

## 📱 Screens & Flows

| Screen | Description |
|---|---|
| **✨ Welcome Screen** | High-impact landing with dark gradient background, glowing artisanal badge, and animated "Get Started" call to action. |
| **☕ Home Catalog** | Location selector, notification center modal, real-time search bar, promo voucher carousel, category filter chips, and responsive coffee card grid. |
| **🔍 Product Detail** | Hero image transition, interactive Size Picker (`S: 250ml`, `M: 350ml`, `L: 450ml`), Milk & Sweetness chips, flavor notes, live dynamic pricing, and sticky Add-to-Cart bar. |
| **🛒 Shopping Cart** | Quantity steppers, swipe-to-delete, coupon voucher input (`COFFEE20`), transparent price breakdown, and checkout trigger. |
| **🎉 Order Success** | Animated celebration dialog with estimated pickup time, earned loyalty stamps (+1 Stamp), and direct order tracking. |
| **❤️ Saved Favorites** | Quick-access screen of saved coffee roasts with 1-tap quick add and empty state illustration. |
| **👤 Profile & Rewards** | User profile card, Coffee Stamp Loyalty Card ("Buy 5 Get 1 Free"), active order status timeline, and brewing preferences. |

---

## 🏗️ Project Architecture

The project follows a clean, modular, and maintainable folder structure:

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_colors.dart         # Design tokens, gradients & color palette
│   │   ├── app_typography.dart     # GoogleFonts Pacifico & Outfit typography scale
│   │   └── app_theme.dart          # Centralized ThemeData definition
│   └── utils/
│       └── snackbar_helper.dart    # Floating glassmorphic toast notification helper
├── models/
│   ├── coffee_item.dart            # Coffee model, size extensions & artisan catalog
│   ├── cart_item.dart              # Cart item model with unit & total price calculations
│   └── category_model.dart         # Category tabs with icons and filtering keys
├── state/
│   ├── shop_state_controller.dart  # Centralized reactive ChangeNotifier state controller
│   └── shop_state_provider.dart    # InheritedNotifier provider & BuildContext extensions
├── screen/ (or screens/)
│   ├── main_navigation_screen.dart # IndexedStack navigation host with floating bottom dock
│   ├── welcome_screen.dart         # Welcome hero screen
│   ├── home_screen.dart            # Home catalog, search & promo banners
│   ├── single_item_screen.dart     # Interactive product customizer & detail view
│   ├── cart_screen.dart            # Shopping cart with voucher discounts & checkout
│   ├── favorites_screen.dart       # Saved favorites screen
│   └── profile_screen.dart         # User profile, loyalty stamp card & order tracker
└── widgets/
    ├── custom_search_bar.dart      # Real-time search with clear & filter modal
    ├── promo_banner_card.dart      # High-conversion promo carousel (20% off)
    ├── category_chip_bar.dart      # Smooth pill category selector
    ├── coffee_card.dart            # Glassmorphic product card with Hero image & rating
    ├── size_selector_widget.dart   # Interactive S/M/L cup size picker
    ├── custom_bottom_nav_bar.dart  # Floating navigation bar with dynamic badge indicators
    ├── home_bottom_bar.dart        # Backward-compatible navigation bar alias
    ├── items_widget.dart           # Backward-compatible responsive catalog grid
    └── order_success_dialog.dart   # Animated order celebration dialog
```

---

## ⚙️ Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (`>= 3.4.1` or higher)
- [Dart SDK](https://dart.dev/get-dart) (`>= 3.4.1 < 4.0.0`)
- Android Studio / VS Code with Flutter extension

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/bhaumik-1910/Flutter_Shop_UI.git
cd Flutter_Shop_UI
```

### 2️⃣ Install Dependencies
```bash
flutter pub get
```

### 3️⃣ Run the Application
```bash
# Run on connected device or emulator
flutter run

# Run on Chrome (Web)
flutter run -d chrome
```

---

## 🧪 Testing & Code Quality

### Run Static Analysis
The codebase is 100% compliant with standard Flutter lints, containing **0 warnings and 0 errors**:
```bash
dart analyze
# Output: Analyzing Flutter_Shop_UI... No issues found!
```

### Run Automated Unit & Widget Tests
```bash
flutter test
# Output: All tests passed!
```

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 👤 Author

**Bhaumik Patel**  
- GitHub: [@bhaumik-1910](https://github.com/bhaumik-1910)

---

<div align="center">
  <sub>Built with ☕ and Flutter. If you find this project inspiring, please give it a ⭐!</sub>
</div>
