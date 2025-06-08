import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:recipe_app/data/models/infoRecipesModel.dart';

class ConnectionJson {
  Future<InfoRecipesModel> loadAppInfo() async {
    final rootFile = await rootBundle.loadString(
      "assets/data/infoRecipes.json",
    );
    final Map<String, dynamic> jsonData = jsonDecode(rootFile);
    return InfoRecipesModel.fromJSON(jsonData);
  }
}
