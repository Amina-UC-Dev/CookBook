import 'package:flutter/material.dart';

class CookDish{
  String id,name,image;
  List<String> recipes;
  int quantity;

  CookDish({required this.id,required this.name,required this.quantity,required this.recipes,required this.image});
}