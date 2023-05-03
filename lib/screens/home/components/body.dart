// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:plant_app/screens/home/components/featured_plants.dart';
import 'package:plant_app/screens/home/components/recomment_plants.dart';
import 'package:plant_app/screens/home/components/search.dart';
import 'package:plant_app/screens/home/components/title_button.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Search(size: size),
          TitleButton(
            title: "Recommended",
            press: () {},
          ),
          const RecommendPlants(),
          TitleButton(
            title: "Featured Plants",
            press: () {},
          ),
          const FeaturedPlants()
        ],
      ),
    );
  }
}
