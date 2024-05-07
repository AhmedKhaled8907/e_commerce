import 'package:e_commerce/consts/theme_data.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/prodcut_provider.dart';
import 'package:e_commerce/providers/theme_provider.dart';
import 'package:e_commerce/screens/auth/forgot_password_screen.dart';
import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:e_commerce/screens/auth/register_screen.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/inner_screen/order/orders_screen.dart';
import 'package:e_commerce/screens/inner_screen/product_details.dart';
import 'package:e_commerce/screens/profile/viewed_recently_screen.dart';
import 'package:e_commerce/screens/profile/wishlist_screen.dart';
import 'package:e_commerce/screens/root_screen.dart';
import 'package:e_commerce/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Smart Shop',
          theme: Styles.themeData(
            isDarkTheme: themeProvider.getIsDarkTheme,
            context: context,
          ),
          home: const RootScreen(),
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            ProductDetails.routeName: (context) => const ProductDetails(),
            WishlistScreen.routeName: (context) => const WishlistScreen(),
            ViewdRecently.routeName: (context) => const ViewdRecently(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            OrdersScreen.routeName: (context) => const OrdersScreen(),
            SearchScreen.routeName: (context) => const SearchScreen(),
            ForgotPasswordScreen.routeName: (context) =>
                const ForgotPasswordScreen(),
          },
        );
      }),
    );
  }
}
