import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app/Provider/favorite_provider.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/data/models/infoRecipesModel.dart';
import 'package:recipe_app/views/recipe_detail_screen.dart';

class FoodItemsDisplay extends StatefulWidget {
  final RecipesModel recipe;
  const FoodItemsDisplay({super.key, required this.recipe});

  @override
  State<FoodItemsDisplay> createState() => _FoodItemsDisplayState();
}

class _FoodItemsDisplayState extends State<FoodItemsDisplay> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: widget.recipe),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        width: 230,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.recipe.image,
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.recipe.image),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.recipe.title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Wrap(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      widget.recipe.terms
                          .take(3)
                          .map((term) => construirWidgetsTermino(term))
                          .expand((widgetList) => widgetList)
                          .toList(),
                ),
              ],
            ),
            //for favorite button
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: kBannerColor,
                child: InkWell(
                  onTap: () {
                    provider.toggleFavorite(widget.recipe);
                  },
                  child: Icon(
                    provider.isExist(widget.recipe)
                        ? Iconsax.heart5
                        : Iconsax.heart,
                    color:
                        provider.isExist(widget.recipe)
                            ? Colors.red
                            : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
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
