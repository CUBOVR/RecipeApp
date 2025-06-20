import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Provider/favorite_provider.dart';
import 'package:recipe_app/Provider/quatify.dart';
import 'package:recipe_app/views/app_main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //for favorite provider
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        //for quantify provider
        ChangeNotifierProvider(create: (_) => QuatifyProvider()),
      ],
      child: const MaterialApp(home: AppMainScreen()),
    );
  }
}
