import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Provider/favorite_provider.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/data/connectionJson.dart';
import 'package:recipe_app/data/models/infoRecipesModel.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final Future<Map<String, dynamic>> _appRecipesInfo =
      ConnectionJson().getCombinedData();
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoriteItems = provider.favorites;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: Text("Favorites", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          if (favoriteItems.isEmpty) {
            return const Center(
              child: Text(
                "No favorites Yet!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                String favorite = favoriteItems[index];
                return FutureBuilder(
                  future: _appRecipesInfo,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Center(
                        child: Text(
                          "Error loading favorites: ${snapshot.error}",
                        ),
                      );
                    }
                    var favoriteItem = snapshot.data!['Recipes'].firstWhere(
                      (recipe) => recipe.id == favorite,
                    );
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(favoriteItem.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        favoriteItem.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      SizedBox(height: 5),
                                      Wrap(
                                        spacing: 4,
                                        runSpacing: 2,
                                        children: [
                                          for (var term in favoriteItem.terms)
                                            ...construirWidgetsTermino(term),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //for delete button
                        Positioned(
                          top: 60,
                          right: 20,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                provider.toggleFavorite(favoriteItem);
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  List<Widget> construirWidgetsTermino(Terms term) {
    switch (term.slug) {
      case 'time':
        return [
          iconAditional(Iconsax.clock),
          aditionalInfo(term.display),
          aditionalInfo(" - "),
        ];
      case 'skillLevel':
        return [
          iconAditional(Iconsax.flash),
          aditionalInfo(term.display),
          aditionalInfo(" - "),
        ];
      case 'vegetarian':
      case 'vegan':
      case 'gluten-free':
        return [iconAditional(Iconsax.heart), aditionalInfo(term.display)];
      case 'healthy':
        return [
          iconAditional(Iconsax.health),
          aditionalInfo(term.display),
          aditionalInfo(" - "),
        ];
      default:
        return []; // No mostrar nada si no lo reconoces
    }
  }

  Text aditionalInfo(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
      ),
    );
  }

  Icon iconAditional(IconData icon) {
    return Icon(icon, size: 16, color: Colors.blueGrey);
  }
}
