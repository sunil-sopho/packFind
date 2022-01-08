import 'package:flutter/material.dart';

import 'package:pack/config/constants.dart';
import 'package:pack/views/widgets/common.dart';
import 'package:pack/controllers/utils.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.des,
    // this.image,
  }) : super(key: key);
  final String? text;
  final String? des;
  // , image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        // Text(
        //   "PackFND",
        //   style: TextStyle(
        //     fontSize: getProportionateScreenWidth(42),
        //     color: kPrimaryColor,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        const LogoWidget(width: 210, height: 220),
        Spacer(),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(30),
          child: Text(
            des!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(14),
            ),
          ),
        ),
        const Spacer(flex: 1),
        // Image.asset(
        //   image,
        //   height: getProportionateScreenHeight(265),
        //   width: getProportionateScreenWidth(235),
        // ),
      ],
    );
  }
}
