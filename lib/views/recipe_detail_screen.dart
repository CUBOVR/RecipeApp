import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Provider/favorite_provider.dart';
import 'package:recipe_app/Provider/quatify.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/data/models/infoRecipesModel.dart';
import 'package:recipe_app/widget/icon_button.dart';
import 'package:recipe_app/widget/quantify_increment_decrement.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipesModel recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  void initState() {
    super.initState();
    //initialize base ingredient amounts in the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      List<double> baseAmounts =
          widget.recipe.ingredientsAmount
              .map<double>((amount) => double.parse(amount.toString()))
              .toList();
      Provider.of<QuatifyProvider>(
        context,
        listen: false,
      ).setBaseIngredientAmounts(baseAmounts);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final quatifyProvider = Provider.of<QuatifyProvider>(context);
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
                //for top back buttons
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
                  top: 330, //MediaQuery.of(context).size.width
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
            //for drag handle
            Center(
              child: Container(
                width: 40,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 4,
                    runSpacing: 2,
                    children: [
                      for (var term in widget.recipe.terms)
                        ...construirWidgetsTermino(term),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //for rating
                  Row(
                    children: [
                      const Icon(Iconsax.star1, color: Colors.amber),
                      const SizedBox(width: 5),
                      Text(
                        (widget.recipe.rating.ratingValue).toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("/5 |"),
                      SizedBox(width: 5),
                      Text(
                        "${widget.recipe.rating.ratingCount.toString()} Reviews",
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ingredients",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "How many servings?",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      QuantifyIncrementDecrement(
                        currentNumber: quatifyProvider.currentNumber,
                        onAdd: () => quatifyProvider.increaseQuantify(),
                        onRemove: () => quatifyProvider.decreaseQuantify(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //list of ingredients
                  Column(
                    children: [
                      Row(
                        children: [
                          //ingredients images
                          Column(
                            children:
                                widget.recipe.ingredientsImage
                                    .map<Widget>(
                                      (imageUrl) => Container(
                                        height: 60,
                                        width: 60,
                                        margin: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(imageUrl),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                          const SizedBox(width: 20),
                          //ingredients name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                widget.recipe.ingredientsName
                                    .map<Widget>(
                                      (ingredient) => SizedBox(
                                        height: 70,
                                        child: Center(
                                          child: Text(
                                            ingredient,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                          //ingredient amount
                          const Spacer(),
                          Column(
                            children:
                                quatifyProvider.updateIngredientAmounts
                                    .map<Widget>(
                                      (amount) => SizedBox(
                                        height: 70,
                                        child: Center(
                                          child: Text(
                                            "${amount}gm",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
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
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
      ),
    );
  }

  Icon iconAditional(IconData icon) {
    return Icon(icon, size: 20, color: Colors.blueGrey);
  }
}
