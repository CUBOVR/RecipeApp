import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:recipe_app/data/models/infoRecipesModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionJson {
  Future<InfoRecipesModel> loadAppInfo() async {
    final rootFile = await rootBundle.loadString(
      "assets/data/infoRecipes.json",
    );
    final Map<String, dynamic> jsonData = jsonDecode(rootFile);
    return InfoRecipesModel.fromJSON(jsonData);
  }

  Future<void> saveFavoriteStatus(String productId, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('favorite_$productId', isFavorite);
  }

  Future<bool> getFavoriteStatus(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('favorite_$productId') ?? false;
  }

  Future<Map<String, dynamic>> getCombinedData() async {
    final data = await loadAppInfo();
    final prefs = await SharedPreferences.getInstance();

    final List<dynamic> recipes = data.recipes;

    for (var item in recipes) {
      final id = item['id'];
      final isFavorite = prefs.getBool('favorite_$id');
      if (isFavorite != null) {
        item['isFavorite'] = isFavorite; // Sobrescribe el valor del JSON
      }
    }

    return {'Recipes': recipes, 'App-Category': data.category};
  }
}
