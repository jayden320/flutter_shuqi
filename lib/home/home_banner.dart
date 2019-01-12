import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'home_model.dart';

class HomeBanner extends StatelessWidget {
  final List<CarouselInfo> carouselInfos;

  HomeBanner(this.carouselInfos);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (carouselInfos.length == 0) {
      return SizedBox();
    }

    return Container(
      color: Colors.white,
      child: CarouselSlider(
        items: carouselInfos.map((info) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: screenWidth,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.network(
                  info.imageUrl ?? '',
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
        aspectRatio: 2,
        interval: const Duration(seconds: 5),
        autoPlay: true,
      ),
    );
  }
}
