import 'package:cookbook/const/colors.dart';
import 'package:cookbook/const/styles.dart';
import 'package:cookbook/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Bags extends StatelessWidget {
  const Bags({Key? key}) : super(key: key);

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
          child: Text("Cook Dishes",
              style: Style()
                  .logoStyle(size: 23, w: FontWeight.w200, color: primary)),
        ),
      ),
      body: Consumer<CookBookProvider>(
        builder: (context,provider,child){
          return provider.cookDishes.length > 0 ? ListView.builder(
              itemCount: provider.cookDishes.length,
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
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.center,
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
                                        decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                        child: Image.asset(
                                          provider.cookDishes[index].image,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Container(width: w-140,
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(width: w-170,
                                            child: Text(
                                              provider.cookDishes[index].name,
                                              style: Style().textStyle(
                                                  size: 16, w: FontWeight.w600, color: black),
                                            ),
                                          ),
                                          Container(
                                              width: 30,height: 30,
                                              child: IconButton(
                                                  padding: EdgeInsets.zero,onPressed: (){
                                                    provider.deleteDish(provider.cookDishes[index]);
                                              }, icon: Icon(Icons.delete_outline,color: red,size: 25,)))
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text(
                                            "Quantity: ",
                                            style: Style().textStyle(
                                                size: 13, w: FontWeight.w600, color: black),
                                          ),
                                          Text(provider.cookDishes[index].quantity.toString(),style: Style().textStyle(
                                              size: 13, w: FontWeight.w400, color: g8),)
                                        ],
                                      ),
                                      SizedBox(height: 2,),
                                      Row(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Recipe: ",
                                            style: Style().textStyle(
                                                size: 13, w: FontWeight.w600, color: black),
                                          ),
                                          Container(width: w-200,
                                            child: Text(provider.cookDishes[index].recipes.join(","),style: Style().textStyle(
                                                size: 13, w: FontWeight.w400, color: g8),),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }) : Center(child:ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(colors: [
              primary,
              primary3,
            ]).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text("No Data",
                style: Style()
                    .logoStyle(size: 23, w: FontWeight.w200, color: primary)),
          ),);
        },
      ),
    );
  }
}
