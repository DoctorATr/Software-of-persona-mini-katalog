import 'package:flutter/material.dart';
import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';

void main() { 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: Colors.white,foregroundColor: Colors.black,elevation: 0,),
        ),
        home: HomeScreen(),
        

      initialRoute: '/',
      routes: {
        '/detail': (context) =>  ProductDetailScreen(),
        '/cart': (context) => CartScreen(),
      },
    );
  }
}
