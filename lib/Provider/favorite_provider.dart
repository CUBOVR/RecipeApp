import 'package:flutter/material.dart';
import 'package:recipe_app/data/connectionJson.dart';
import 'package:recipe_app/data/models/infoRecipesModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoritesIds = [];
  List<String> get favorites => _favoritesIds;
  final Future<InfoRecipesModel> _localData = ConnectionJson().loadAppInfo();

  FavoriteProvider() {
    loadFavorites();
  }

  //toggle favorites states
  void toggleFavorite(RecipesModel product) async {
    String productId = product.id;
    if (_favoritesIds.contains(productId)) {
      _favoritesIds.remove(productId);
      await _removeFavorite(productId); //remove from favorite
    } else {
      _favoritesIds.add(productId);
      await _addFavorite(productId); //add to favorite
    }
    notifyListeners();
  }

  //check if a product is favorited
  bool isExist(RecipesModel product) {
    return _favoritesIds.contains(product.id);
  }

  //add favorites to database
  Future<void> _addFavorite(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('favorite_$productId', true);
  }

  //add favorites to database
  Future<void> _removeFavorite(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('favorite_$productId');
  }

  Future<bool> getFavoriteStatus(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('favorite_$productId') ?? false;
  }

  //load favorites from SharedPreferences
  Future<void> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();

      _favoritesIds =
          allKeys
              .where((key) => key.startsWith('favorite_'))
              .where((key) => prefs.getBool(key) == true)
              .map((key) => key.replaceFirst('favorite_', ''))
              .toList();
    } catch (e) {
      print('Error loading favorites: $e');
    }

    notifyListeners(); // Si estás en un ChangeNotifier
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
