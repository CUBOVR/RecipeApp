import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';

class InfoRecipesModel {
  final List<RecipesModel> recipes;
  final List<Categories> category;

  InfoRecipesModel({required this.recipes, required this.category});

  factory InfoRecipesModel.fromJSON(Map<String, dynamic> json) {
    return InfoRecipesModel(
      recipes:
          (json["Recipes"] as List)
              .map((e) => RecipesModel.fromJSON(e))
              .toList(),
      category:
          (json["App-Category"] as List)
              .map((e) => Categories.fromJSON(e))
              .toList(),
    );
  }
}

class RecipesModel {
  final String title;
  final RatingInfo rating;
  final String url;
  final String image;
  final String category;
  final String description;
  final String published;
  final String authorName;
  final List<Terms> terms;

  RecipesModel({
    required this.title,
    required this.rating,
    required this.url,
    required this.image,
    required this.category,
    required this.description,
    required this.published,
    required this.authorName,
    required this.terms,
  });

  factory RecipesModel.fromJSON(Map<String, dynamic> json) {
    return RecipesModel(
      title: json["title"],
      rating: RatingInfo.fromJSON(json["rating"]),
      url: json["url"],
      image: json["image"]["url"],
      category: json["category"],
      description: json["description"],
      published: json["published"],
      authorName: json["authorName"],
      terms: (json["terms"] as List).map((e) => Terms.fromJSON(e)).toList(),
    );
  }
}

class RatingInfo {
  final double ratingValue;
  final int ratingCount;
  final int commentCount;
  final String ratingTypeLabel;
  final bool hasRatingCount;
  final bool isHalfStar;

  RatingInfo({
    required this.ratingValue,
    required this.ratingCount,
    required this.commentCount,
    required this.ratingTypeLabel,
    required this.hasRatingCount,
    required this.isHalfStar,
  });

  factory RatingInfo.fromJSON(Map<String, dynamic> json) {
    return RatingInfo(
      ratingValue: (json["ratingValue"]).toDouble(),
      ratingCount: json["ratingCount"],
      commentCount: json["commentCount"],
      ratingTypeLabel: json["ratingTypeLabel"],
      hasRatingCount: json["hasRatingCount"],
      isHalfStar: json["isHalfStar"],
    );
  }
}

class Terms {
  final String slug;
  final String display;

  Terms({required this.slug, required this.display});

  factory Terms.fromJSON(Map<String, dynamic> json) {
    return Terms(slug: json["slug"], display: json["display"]);
  }
}

class Categories {
  final String name;

  Categories({required this.name});

  factory Categories.fromJSON(Map<String, dynamic> json) {
    return Categories(name: json["name"]);
  }
}
