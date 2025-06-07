import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';

class InfoRecipesModel {
  final List<RecipesModel> recipes;
  final List<Categories> category;

  InfoRecipesModel({required this.recipes, required this.category});

  factory InfoRecipesModel.fromJSON(Map<String, dynamic> json) {
    return InfoRecipesModel(
      recipes: List<RecipesModel>.from(json["Recipes"]),
      category: List<Categories>.from(json["App-Category"]),
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
      rating: json["rating"],
      url: json["url"],
      image: json["image"]["url"],
      category: json["category"],
      description: json["description"],
      published: json["published"],
      authorName: json["authorName"],
      terms: List<Terms>.from(json["terms"]),
    );
  }
}

class RatingInfo {
  final double ratingValue;
  final Int ratingCount;
  final Int commentCount;
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
      ratingValue: json["ratinValue"],
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
