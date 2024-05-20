import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/cart/cart_screen.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/profile/profile_screen.dart';
import 'package:e_commerce/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  static const routeName = '/rootScreen';

  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController controller;
  int currentScreen = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(
      isEmpty: false,
    ),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: currentScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        indicatorColor: Colors.blueAccent.shade700,
        selectedIndex: currentScreen,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
            controller.jumpToPage(currentScreen);
          });
        },
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.home),
            icon: Icon(IconlyLight.home),
            label: 'Home',
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.search),
            icon: Icon(IconlyLight.search),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: const Icon(IconlyBold.bag2),
            icon: Badge(
              backgroundColor: Colors.blueAccent.shade700,
              textColor: Colors.white,
              label: Text('${cartProvider.getCarts.length}'),
              child: const Icon(IconlyLight.bag2),
            ),
            label: 'Cart',
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.profile),
            icon: Icon(IconlyLight.profile),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
