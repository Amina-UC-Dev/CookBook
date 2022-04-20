import 'package:cookbook/const/colors.dart';
import 'package:cookbook/const/styles.dart';
import 'package:cookbook/provider/provider.dart';
import 'package:cookbook/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({Key? key}) : super(key: key);

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
          child: Text("Recipes",
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
      body: Consumer<CookBookProvider>(
        builder: (context,provider,child){
          return ResponsiveGridList(
              horizontalGridMargin: 20,
              verticalGridMargin: 25,
              minItemWidth: w / 2.5,verticalGridSpacing: 20,
              shrinkWrap: true,horizontalGridSpacing: 8,
              children: List.generate(
                provider.cookBook!.recipes.length,
                    (index) {
                  return InkWell(
                    onTap: (){
                      PageNavigation().gotoRecipeDetail(context,provider.cookBook!.recipes[index]);
                    },
                    child: Card(
                      color: white,
                      shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 10,top: 10,bottom: 10),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: Container(
                                  width: 95,
                                  height: 95,
                                  child: Center(
                                    child: Container(height: 88,width: 88,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(shape: BoxShape.circle),
                                        child: Image.asset(provider.cookBook!.recipes[index].recipeImage,fit: BoxFit.cover,)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              provider.cookBook!.recipes[index].recipeName,
                              style: Style().textStyle(
                                  size: 15, w: FontWeight.w600, color: black),textAlign: TextAlign.start,
                            ),
                           Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Opacity(
                                  opacity:  provider.cookBook!.recipes[index].addRecipe == false ? 1 : .5,
                                  child: MaterialButton(padding: EdgeInsets.symmetric(horizontal: 10),height: 30,
                                    color: primary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    onPressed: (){
                                    if( provider.cookBook!.recipes[index].addRecipe == false){
                                      provider.cookThisDish(provider.cookBook!.recipes[index],context);
                                    }
                                    },child: Text("Cook This Dish",style: Style().textStyle(size: 13, w: FontWeight.w100, color: white),),),
                                )
                              ],)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
        },
      ),
    );
  }
}
