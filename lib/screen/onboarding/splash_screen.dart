import 'dart:async';
import 'package:cookbook/const/colors.dart';
import 'package:cookbook/const/styles.dart';
import 'package:cookbook/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }
  timer() async {
    Provider.of<CookBookProvider>(context, listen: false).writeContent();
    Timer(Duration(seconds: 3), () async{
      PageNavigation().gotoDashboard(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/logo.png",height: w/1.5,),
          SizedBox(height: 15,),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(colors: [
              primary,primary2,primary3
            ]).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text("CookBook", style: Style().logoStyle(size: 40, w: FontWeight.w500, color: primary)),
          )
        ],
      )),
    );
  }
}
