import 'package:cookbook/const/colors.dart';
import 'package:cookbook/const/styles.dart';
import 'package:cookbook/provider/provider.dart';
import 'package:cookbook/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class IngredientList extends StatelessWidget {
  const IngredientList({Key? key}) : super(key: key);

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
          child: Text("Ingredients",
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
        builder: (context, provider, child) {
          return ListView.builder(
              itemCount: provider.cookBook!.ingredients.length,
              padding: EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: Container(
                                  width: 75,
                                  height: 75,
                                  child: Center(
                                    child: Container(
                                        height: 68,
                                        width: 68,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: Image.asset(
                                          provider.cookBook!.ingredients[index]
                                              .ingrediantImage,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(width: w-200-7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.cookBook!.ingredients[index]
                                          .ingredientName,
                                      style: Style().textStyle(
                                          size: 15,
                                          w: FontWeight.w600,
                                          color: black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Code: ",
                                          style: Style().textStyle(
                                              size: 13,
                                              w: FontWeight.w600,
                                              color: black),
                                        ),
                                        Text(
                                          provider
                                              .cookBook!.ingredients[index].sku,
                                          style: Style().textStyle(
                                              size: 13,
                                              w: FontWeight.w500,
                                              color: black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "\$${provider.cookBook!.ingredients[index].ingredientPrice}",
                            style: Style().textStyle(
                                size: 16, w: FontWeight.w600, color: green),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
