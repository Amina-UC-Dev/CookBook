import 'package:cookbook/const/colors.dart';
import 'package:cookbook/const/styles.dart';
import 'package:cookbook/model/cookbook_model.dart';
import 'package:cookbook/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class RecipeDetail extends StatelessWidget {
  RecipeDetail({Key? key,required this.recipe}) : super(key: key);

  Recipe recipe;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: white,
        elevation: 0,
        title: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(colors: [
            primary,
            primary2,
            primary3,
          ]).createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text("Recipe",
              style: Style()
                  .logoStyle(size: 23, w: FontWeight.w200, color: primary)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4),
            child: Stack(alignment: Alignment.topRight,
              children: [
                IconButton(
                    onPressed: () {
                      PageNavigation().gotoBag(context);
                    },
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: primary,
                      size: 30,
                    )),
                Consumer<CookBookProvider>(
                  builder: (context,provider,child){
                    return provider.cookDishes.length > 0 ? CircleAvatar(
                      radius: 10,
                      backgroundColor: primary3,
                      child: Center(
                          child: Text(
                            provider.cookDishes.length.toString(),
                            style: TextStyle(fontSize: 11,color: white),
                          )),
                    ) : Container();
                  },
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(height: 10,),
                  Center(
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Container(
                        width: w/2.3,
                        height: w/2.3,
                        child: Center(
                          child: Container(height: w/2.3-10,width: w/2.3-10,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Image.asset(recipe.recipeImage,fit: BoxFit.cover,)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    recipe.recipeName,
                    style: Style().textStyle(
                        size: 20, w: FontWeight.w600, color: black),textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Text(
                "Ingredients:",
                style: Style().textStyle(
                    size: 16, w: FontWeight.w900, color: black),textAlign: TextAlign.start,
              ),
              SizedBox(height: 10,),
              for(int i=0;i<recipe.ingredients.length;i++)
                IngredientTile(name: "${i+1}. "+recipe.ingredients[i].ingredientName, ),
              SizedBox(height: 30,),
              Center(
                child: Opacity(
                  opacity: recipe.addRecipe == false ? 1 : .4,
                  child: MaterialButton(padding: EdgeInsets.symmetric(horizontal: 10),height: 40,minWidth: w/2,
                    color: primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: (){
                      Provider.of<CookBookProvider>(context, listen: false).cookThisDish(recipe,context);
                    },child: Text("Cook This Dish",style: Style().textStyle(size: 16, w: FontWeight.w200, color: white),),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class IngredientTile extends StatelessWidget {
  IngredientTile({Key? key,required this.name}) : super(key: key);

  String name;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
      child: Text(name,style: Style().textStyle(size: 14, w: FontWeight.w400, color: g8),),
    );
  }
}
