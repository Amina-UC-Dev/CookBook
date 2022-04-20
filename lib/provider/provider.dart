import 'dart:convert';
import 'dart:io';
import 'package:cookbook/model/cook_dishes.dart';
import 'package:logger/logger.dart';
import 'package:cookbook/model/cookbook_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CookBookProvider extends ChangeNotifier {
  CookBook? cookBook;

  List<CookDish> cookDishes = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print("APP DIRECTORY");
    print(directory.path);
    return directory.path;
  }

  Future<File> get _cookBookList async {
    final path = await _localPath;
    return File('$path/cookBook.json');
  }

  Future writeContent() async {
    final file = await _cookBookList;
    file.writeAsString(json.encode({
      "ingredients": [
        {
          "sku": "ING1",
          "ingredient_name": "Egg",
          "ingredient_image": "assets/egg.jpg",
          "ingredient_price": 2.00
        },
        {
          "sku": "ING2",
          "ingredient_name": "Butter",
          "ingredient_image": "assets/butter.jpg",
          "ingredient_price": 70.00
        },
        {
          "sku": "ING3",
          "ingredient_name": "Tomato",
          "ingredient_image": "assets/tomato.jpg",
          "ingredient_price": 40.00
        },
        {
          "sku": "ING4",
          "ingredient_name": "Green Chilly",
          "ingredient_image": "assets/chilly.jpg",
          "ingredient_price": 30.00
        },
        {
          "sku": "ING5",
          "ingredient_name": "Salt",
          "ingredient_image": "assets/salt.jpg",
          "ingredient_price": 10.00
        },
        {
          "sku": "ING6",
          "ingredient_name": "MAGGI Indian Cooking Paste",
          "ingredient_image": "assets/maggi_paste.jpg",
          "ingredient_price": 130.00
        },
        {
          "sku": "ING7",
          "ingredient_name": "Chicken",
          "ingredient_image": "assets/chicken.jpg",
          "ingredient_price": 150.00
        },
        {
          "sku": "ING8",
          "ingredient_name": "Oil",
          "ingredient_image": "assets/oil.jpg",
          "ingredient_price": 90.00
        },
        {
          "sku": "ING9",
          "ingredient_name": "Water",
          "ingredient_image": "assets/water.jpg",
          "ingredient_price": 10.00
        },
        {
          "sku": "ING10",
          "ingredient_name": "Cream",
          "ingredient_image": "assets/cream.png",
          "ingredient_price": 10.00
        },
        {
          "sku": "ING11",
          "ingredient_name": "Coriander Leaves",
          "ingredient_image": "assets/coriander.jpg",
          "ingredient_price": 15.00
        }
      ],
      "recipes": [
        {
          "recipe_id": "rec1",
          "recipe_name": "Chicken  Masala",
          "recipe_image": "assets/chicken_masala.jpg",
          "add_recipe": false,
          "ingredients": [
            {
              "ingredient_id": " ING7",
              "ingredient_name": "Chicken",
              "ingredient_image": "assets/chicken.jpg"
            },
            {
              "ingredient_id": " ING8",
              "ingredient_name": "Oil",
              "ingredient_image": "assets/oil.jpg"
            },
            {
              "ingredient_id": " ING9",
              "ingredient_name": "Water",
              "ingredient_image": "assets/water.jpg"
            },
            {
              "ingredient_id": " ING10",
              "ingredient_name": "Cream",
              "ingredient_image": "assets/cream.png"
            },
            {
              "ingredient_id": " ING11",
              "ingredient_name": "Coriander Leaves",
              "ingredient_image": "assets/coriander.jpg"
            },
            {
              "ingredient_id": " ING6",
              "ingredient_name": "MAGGI Indian Cooking Paste",
              "ingredient_image": "assets/maggi_paste.jpg"
            },
            {
              "ingredient_id": " ING4",
              "ingredient_name": "Green Chilly",
              "ingredient_image": "assets/chilly.jpg"
            },
            {
              "ingredient_id": " ING3",
              "ingredient_name": "Tomato",
              "ingredient_image": "assets/tomato.jpg"
            },
            {
              "ingredient_id": " ING5",
              "ingredient_name": "Salt",
              "ingredient_image": "assets/salt.jpg"
            }
          ]
        },
        {
          "recipe_id": "rec2",
          "recipe_name": "Spanish Omlet",
          "recipe_image": "assets/omlet.jpg",
          "add_recipe": false,
          "ingredients": [
            {
              "ingredient_id": " ING1",
              "ingredient_name": "Egg",
              "ingredient_image": "assets/egg.jpg"
            },
            {
              "ingredient_id": " ING4",
              "ingredient_name": "Green Chilly",
              "ingredient_image": "assets/chilly.jpg"
            },
            {
              "ingredient_id": " ING3",
              "ingredient_name": "Tomato",
              "ingredient_image": "assets/tomato.jpg"
            },
            {
              "ingredient_id": " ING2",
              "ingredient_name": "Butter",
              "ingredient_image": "assets/butter.jpg"
            },
            {
              "ingredient_id": " ING5",
              "ingredient_name": "Salt",
              "ingredient_image": "assets/salt.jpg"
            },
            {
              "ingredient_id": " ING11",
              "ingredient_name": "Coriander Leaves",
              "ingredient_image": "assets/coriander.jpg"
            }
          ]
        }
      ]
    }));
    print("FILE CREATED");
  }

  void getData(BuildContext context) async {
    final file = await _cookBookList;
    if (await file.exists() == true) {
      CookBook? contents =
          CookBook.fromJson(json.decode(await file.readAsString()));
      cookBook = contents;
      notifyListeners();
      print("DATA : ");
      Logger().d(cookBook!.toJson());
    } else {}
    notifyListeners();
  }

  deleteDish(CookDish dish){
    cookDishes.remove(dish);
    notifyListeners();
  }

  cookThisDish(Recipe data, BuildContext context) {
    try{
    for (int i = 0; i < data.ingredients.length; i++) {
     if(cookDishes.length > 0){
        List<CookDish> content =
       cookDishes.where((element) => element.id== data.ingredients[i].ingredientId).toList();
       if(content.length>0){
         cookDishes.forEach((element) {
           if(element.id == content.first.id){
             List<String> recipes = element.recipes;
             recipes.add(data.recipeName);
             element.quantity= element.quantity+1;
           }
         });
         notifyListeners();
       }else{
         cookDishes.add(CookDish(
             id: data.ingredients[i].ingredientId,
             name: data.ingredients[i].ingredientName,
             quantity: 1,
             image: data.ingredients[i].ingredientImage,
             recipes: [data.recipeName]));
       }
     }else{
       cookDishes.add(CookDish(
         image: data.ingredients[i].ingredientImage,
           id: data.ingredients[i].ingredientId,
           name: data.ingredients[i].ingredientName,
           quantity: 1,
           recipes: [data.recipeName]));
     }
      print("COOK DISHES : "+cookDishes.length.toString());
    }
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Ingredients added to Bag"),
    ));}catch(e){print("ERRROIRRR ${e}");}
  }
}
