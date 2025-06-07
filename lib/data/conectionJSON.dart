import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:recipe_app/data/models/infoRecipesModel.dart';

class ConectionJSON {
  Future<InfoRecipesModel> fetchAppInfo() async {
    final String rootFile = await rootBundle.loadString(
      "assets/data/infoRecipes.json",
    );
    InfoRecipesModel jsonData = jsonDecode(rootFile);
    return jsonData;
  }
}
