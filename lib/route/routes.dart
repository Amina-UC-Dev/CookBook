import 'package:cookbook/model/cookbook_model.dart';
import 'package:cookbook/provider/provider.dart';
import 'package:cookbook/screen/cooking_bag/bag.dart';
import 'package:cookbook/screen/dashboard/dashboard.dart';
import 'package:cookbook/screen/ingredient_list/ingredient_list.dart';
import 'package:cookbook/screen/recipes_list/recipe_detail.dart';
import 'package:cookbook/screen/recipes_list/recipe_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageNavigation {
  gotoDashboard(BuildContext context) {
    Provider.of<CookBookProvider>(context, listen: false).getData(context);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashBoard()),
        (route) => false);
  }

  gotoIngredients(BuildContext context) {
    // Provider.of<HomeProvider>(context, listen: false).init(context);
    Navigator.push(context,  MaterialPageRoute(builder: (context) => const IngredientList()),);
  }

  gotoRecipes(BuildContext context) {
    // Provider.of<HomeProvider>(context, listen: false).init(context);
    Navigator.push(context,  MaterialPageRoute(builder: (context) => const RecipeList()),);
  }

  gotoRecipeDetail(BuildContext context,Recipe recipe) {
    // Provider.of<HomeProvider>(context, listen: false).init(context);
    Navigator.push(context,  MaterialPageRoute(builder: (context) => RecipeDetail(recipe: recipe,)),);
  }

  gotoBag(BuildContext context) {
    // Provider.of<HomeProvider>(context, listen: false).init(context);
    Navigator.push(context,  MaterialPageRoute(builder: (context) => const Bags()),);
  }
}
