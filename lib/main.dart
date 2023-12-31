import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/providers/theme_provider.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:e_commerce/providers/viewed_prod_provider.dart';
import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:e_commerce/root_screen.dart';
import 'package:e_commerce/screen/auth/forgot_password.dart';
import 'package:e_commerce/screen/auth/login.dart';
import 'package:e_commerce/screen/auth/register.dart';
import 'package:e_commerce/screen/inner_screens/orders/orders_screen.dart';
import 'package:e_commerce/screen/inner_screens/product_details.dart';
import 'package:e_commerce/screen/inner_screens/viewed_recently.dart';
import 'package:e_commerce/screen/inner_screens/wishlist.dart';
import 'package:e_commerce/screen/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      home: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: SelectableText(
                      "An error has been occurred ${snapshot.error}"),
                ),
              );
            }
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => ThemeProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => ProductProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => CartProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => WishlistProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => ViewedProdProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => UserProvider(),
                ),
              ],
              child: Consumer<ThemeProvider>(
                builder: (
                  context,
                  themeProvider,
                  child,
                ) {
                  return MaterialApp(
                    title: 'Shop Smart ',
                    theme: Styles.themeData(
                        isDarkTheme: themeProvider.getIsDarkTheme,
                        context: context),
                    home: const RootScreen(),
                    // home: const RegisterScreen(),
                    routes: {
                      ProductDetails.routName: (context) =>
                          const ProductDetails(),
                      WishlistScreen.routName: (context) =>
                          const WishlistScreen(),
                      ViewedRecentlyScreen.routName: (context) =>
                          const ViewedRecentlyScreen(),
                      RegisterScreen.routName: (context) =>
                          const RegisterScreen(),
                      LoginScreen.routName: (context) => const LoginScreen(),
                      OrdersScreenFree.routeName: (context) =>
                          const OrdersScreenFree(),
                      ForgotPasswordScreen.routeName: (context) =>
                          const ForgotPasswordScreen(),
                      SearchScreen.routeName: (context) => const SearchScreen(),
                      RootScreen.routName: (context) => const RootScreen(),
                    },
                  );
                },
              ),
            );
          }),
    );
  }
}
