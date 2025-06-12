import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app/core/styles.dart';
import 'package:recipe_app/data/connectionJson.dart';
import 'package:recipe_app/data/models/infoRecipesModel.dart';
import 'package:recipe_app/widget/food_items_display.dart';
import 'package:recipe_app/widget/icon_button.dart';

class ViewAllItems extends StatefulWidget {
  const ViewAllItems({super.key});

  @override
  State<ViewAllItems> createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> {
  Future<InfoRecipesModel?>? _appRecipesInfo;
  ConnectionJson repository = ConnectionJson();

  @override
  void initState() {
    super.initState();
    _appRecipesInfo = repository.loadAppInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          SizedBox(width: 15),
          MyIconButton(
            icon: Icons.arrow_back_ios_new,
            pressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          Text(
            "Quick & Easy",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          MyIconButton(icon: Iconsax.notification, pressed: () {}),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 5),
        child: Column(
          children: [
            const SizedBox(height: 10),
            FutureBuilder(
              future: _appRecipesInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text("No se encontraron datos"));
                }
                return GridView.builder(
                  itemCount: snapshot.data!.recipes.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final RecipesModel recipe = snapshot.data!.recipes[index];
                    return Column(
                      children: [
                        FoodItemsDisplay(recipe: recipe),
                        Row(
                          children: [
                            Icon(Iconsax.star1, color: Colors.amber),
                            SizedBox(width: 5),
                            Text(
                              (recipe.rating.ratingValue).toStringAsFixed(2),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("/5 |"),
                            SizedBox(width: 5),
                            Text(
                              "${recipe.rating.ratingCount.toString()} Reviews",
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
