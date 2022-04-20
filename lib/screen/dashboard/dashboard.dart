import 'package:cookbook/const/colors.dart';
import 'package:cookbook/const/styles.dart';
import 'package:cookbook/provider/provider.dart';
import 'package:cookbook/route/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

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
          shaderCallback: (bounds) =>
              LinearGradient(colors: [primary, primary2, primary3])
                  .createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text("CookBook",
              style: Style()
                  .logoStyle(size: 26, w: FontWeight.w500, color: primary)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
            child: Stack(
              alignment: Alignment.topRight,
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
                  builder: (context, provider, child) {
                    return provider.cookDishes.length > 0
                        ? CircleAvatar(
                            radius: 10,
                            backgroundColor: primary3,
                            child: Center(
                                child: Text(
                              provider.cookDishes.length.toString(),
                              style: TextStyle(fontSize: 11, color: white),
                            )),
                          )
                        : Container();
                  },
                )
              ],
            ),
          )
        ],
      ),
      body: Consumer<CookBookProvider>(
        builder: (context, provider, child) {
          return Center(
            child: provider.cookBook != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            PageNavigation().gotoIngredients(context);
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Color(0xFFff8d7e),
                            child: Container(
                              width: w - 8,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  direction: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 40),
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          for (int ind = 0;
                                              provider.cookBook!.ingredients
                                                          .length >
                                                      4
                                                  ? ind < 4
                                                  : ind <
                                                      provider.cookBook!
                                                          .ingredients.length;
                                              ind++)
                                            ind <= 2
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: ind == 0
                                                            ? 0
                                                            : (w / 6) * ind),
                                                    child: Card(
                                                      elevation: 4,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100)),
                                                      child: Container(
                                                        height: w / 3,
                                                        width: w / 3,
                                                        child: Center(
                                                          child: Container(
                                                              height:
                                                                  w / 3 - 10,
                                                              width: w / 3 - 10,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle),
                                                              child:
                                                                  Image.asset(
                                                                provider
                                                                    .cookBook!
                                                                    .ingredients[
                                                                        ind]
                                                                    .ingrediantImage,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        left: (w / 4.8) * 3),
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: primary2,
                                                      child: Text(
                                                        (provider
                                                                        .cookBook!
                                                                        .ingredients
                                                                        .length -
                                                                    3)
                                                                .toString() +
                                                            "+",
                                                        style: Style()
                                                            .textStyle(
                                                                size: 15,
                                                                w: FontWeight
                                                                    .w600,
                                                                color: white),
                                                      ),
                                                    ),
                                                  )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: w / 7, bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Ingredients",
                                            style: Style().textStyle(
                                                size: 22,
                                                w: FontWeight.w600,
                                                color: white),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${provider.cookBook!.ingredients.length} Items",
                                            style: Style().textStyle(
                                                size: 15,
                                                w: FontWeight.w600,
                                                color: white),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            PageNavigation().gotoRecipes(context);
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Color(0xFFffb671),
                            child: Container(
                              width: w - 8,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  direction: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 40),
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          for (int ind = 0;
                                              provider.cookBook!.recipes
                                                          .length >
                                                      4
                                                  ? ind < 4
                                                  : ind <
                                                      provider.cookBook!.recipes
                                                          .length;
                                              ind++)
                                            ind <= 2
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: ind == 0
                                                            ? 0
                                                            : (w / 6) * ind),
                                                    child: Card(
                                                      elevation: 4,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100)),
                                                      child: Container(
                                                        height: w / 3,
                                                        width: w / 3,
                                                        child: Center(
                                                          child: Container(
                                                              height:
                                                                  w / 3 - 10,
                                                              width: w / 3 - 10,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle),
                                                              child:
                                                                  Image.asset(
                                                                provider
                                                                    .cookBook!
                                                                    .recipes[
                                                                        ind]
                                                                    .recipeImage,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        left: (w / 4.8) * 3),
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: primary2,
                                                      child: Text(
                                                        (provider
                                                                        .cookBook!
                                                                        .recipes
                                                                        .length -
                                                                    3)
                                                                .toString() +
                                                            "+",
                                                        style: Style()
                                                            .textStyle(
                                                                size: 15,
                                                                w: FontWeight
                                                                    .w600,
                                                                color: white),
                                                      ),
                                                    ),
                                                  )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: w / 7, bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Recipes",
                                            style: Style().textStyle(
                                                size: 22,
                                                w: FontWeight.w600,
                                                color: white),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${provider.cookBook!.recipes.length} Items",
                                            style: Style().textStyle(
                                                size: 15,
                                                w: FontWeight.w600,
                                                color: white),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
