// To parse this JSON data, do
//
//     final cookBook = cookBookFromJson(jsonString);

import 'dart:convert';

CookBook cookBookFromJson(String str) => CookBook.fromJson(json.decode(str));

String cookBookToJson(CookBook data) => json.encode(data.toJson());

class CookBook {
  CookBook({
    required this.ingredients,
    required this.recipes,
  });

  List<CookBookIngredient> ingredients;
  List<Recipe> recipes;

  factory CookBook.fromJson(Map<String, dynamic> json) => CookBook(
    ingredients: List<CookBookIngredient>.from(json["ingredients"].map((x) => CookBookIngredient.fromJson(x))),
    recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
    "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
  };
}

class CookBookIngredient {
  CookBookIngredient({
    required this.sku,
    required this.ingredientName,
    required this.ingrediantImage,
    required this.ingredientPrice,
  });

  String sku;
  String ingredientName;
  String ingrediantImage;
  double ingredientPrice;

  factory CookBookIngredient.fromJson(Map<String, dynamic> json) => CookBookIngredient(
    sku: json["sku"],
    ingredientName: json["ingredient_name"],
    ingrediantImage: json["ingredient_image"],
    ingredientPrice: json["ingredient_price"],
  );

  Map<String, dynamic> toJson() => {
    "sku": sku,
    "ingredient_name": ingredientName,
    "ingrediant_image": ingrediantImage,
    "ingredient_price": ingredientPrice,
  };
}

class Recipe {
  Recipe({
    required this.recipeId,
    required this.recipeName,
    required this.recipeImage,
    required this.addRecipe,
    required this.ingredients,
  });

  String recipeId;
  String recipeName;
  String recipeImage;
  bool addRecipe;
  List<RecipeIngredient> ingredients;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    recipeId: json["recipe_id"],
    recipeName: json["recipe_name"],
    recipeImage: json["recipe_image"],
    addRecipe: json["add_recipe"],
    ingredients: List<RecipeIngredient>.from(json["ingredients"].map((x) => RecipeIngredient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recipe_id": recipeId,
    "recipe_name": recipeName,
    "recipe_image": recipeImage,
    "add_recipe": addRecipe,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
  };
}

class RecipeIngredient {
  RecipeIngredient({
    required this.ingredientId,
    required this.ingredientName,
    required this.ingredientImage,
  });

  String ingredientId;
  String ingredientName;
  String ingredientImage;

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) => RecipeIngredient(
    ingredientId: json["ingredient_id"],
    ingredientName: json["ingredient_name"],
    ingredientImage: json["ingredient_image"],
  );

  Map<String, dynamic> toJson() => {
    "ingredient_id": ingredientId,
    "ingredient_name": ingredientName,
    "ingredient_image": ingredientImage,
  };
}
