import 'package:flutter/material.dart';
import 'package:recipe_app/data/connectionJson.dart';
import 'package:recipe_app/data/models/infoRecipesModel.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoritesIds = [];
  List<String> get favorites => _favoritesIds;
  final Future<InfoRecipesModel> _localData = ConnectionJson().loadAppInfo();

  FavoriteProvider() {}

  //toggle favorites states
  void toggleFavorite(RecipesModel product) async {
    String productId = product.id;
    if (_favoritesIds.contains(productId)) {
      _favoritesIds.remove(productId);
      await _removeFavorite(productId); //remove from favorite
    } else {
      _favoritesIds.add(productId);
      await _aadFavorite(productId); //add to favorite
    }
    notifyListeners();
  }

  //check if a product is favorited
  bool isExist(RecipesModel product) {
    return _favoritesIds.contains(product.id);
  }

  //add favorites to database
  Future<void> _aadFavorite(String productId) async {
    try {} catch (e) {
      print(e.toString());
    }
  }
}
