import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app/Provider/favorite_provider.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/data/models/infoRecipesModel.dart';
import 'package:recipe_app/widget/icon_button.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipesModel recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: startCookingAndFavoriteButton(provider),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //for image
                Hero(
                  tag: widget.recipe.image,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.recipe.image),
                      ),
                    ),
                  ),
                ),
                //for top buttons
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      MyIconButton(
                        icon: Icons.arrow_back_ios_new,
                        pressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      MyIconButton(icon: Iconsax.notification, pressed: () {}),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.width,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton startCookingAndFavoriteButton(
    FavoriteProvider provider,
  ) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {},
      label: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kBannerColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 10,
              ),
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: const Text(
              "Start Cooking",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            style: IconButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 2),
              ),
            ),
            onPressed: () {
              provider.toggleFavorite(widget.recipe);
            },
            icon: Icon(
              provider.isExist(widget.recipe) ? Iconsax.heart5 : Iconsax.heart,
              color:
                  provider.isExist(widget.recipe) ? Colors.red : Colors.black,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
