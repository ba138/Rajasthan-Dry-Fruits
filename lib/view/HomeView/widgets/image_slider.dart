import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imgList = [
    "images/cartImg.png",
    "images/cartImg.png",
    "images/cartImg.png",
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: 342,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.primaryColor, width: 2),
        color: const Color.fromRGBO(
            255, 255, 255, 0.2), // Background color with opacity
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5), // Shadow color
            blurRadius: 2, // Blur radius
            spreadRadius: 0, // Spread radius
            offset: const Offset(0, 0), // Offset
          ),
        ],
      ),
      child: Column(
        children: [
          const VerticalSpeacing(12),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.boxColor, // Background color with opacity
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.favorite,
                      color: AppColor.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          CarouselSlider(
            items: imgList
                .map(
                  (item) => Container(
                    height: 150,
                    width: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/cartImg.png"),
                      ),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 10,
                onPageChanged: ((index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                })
                // viewportFraction = 0.8,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imgList.length, (index) {
              return Row(
                children: [
                  Container(
                    height: 5,
                    width: currentIndex == index ? 18 : 10,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? AppColor.primaryColor
                          : const Color(0xff898989),
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
