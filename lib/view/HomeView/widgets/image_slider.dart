// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:rjfruits/view_model/save_view_model.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider(
      {super.key,
      required this.image,
      required this.listImage,
      required this.id,
      required this.name,
      required this.discount});
  final String image;
  final List<String> listImage;
  final String id;
  final String name;
  final String discount;
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imgList = [
    // "images/cartImg.png",
    // "images/cartImg.png",
    // "images/cartImg.png",
  ];
  int currentIndex = 0;
  bool isLike = false;
  void checktheProduct() async {
    SaveProductRepositoryProvider homeRepoProvider =
        Provider.of<SaveProductRepositoryProvider>(context, listen: false);

    bool isIncart = await homeRepoProvider.isProductInCart(widget.id);

    if (isIncart == true) {
      setState(() {
        isLike = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checktheProduct();
  }

  @override
  Widget build(BuildContext context) {
    imgList = widget.listImage;
    SaveProductRepositoryProvider saveRepo =
        Provider.of<SaveProductRepositoryProvider>(context, listen: false);

    return Container(
      height: 270,
      width: MediaQuery.of(context).size.width * 9,
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
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        debugPrint("loved");
                        Future<bool> isInCart =
                            saveRepo.isProductInCart(widget.id);

                        if (await isInCart) {
                          setState(() {
                            isLike = true;
                          });
                          Utils.toastMessage("Product is already in the save");
                        } else {
                          setState(() {
                            isLike = true;
                          });
                          saveRepo.saveCartProducts(widget.id, widget.name,
                              widget.image, widget.discount, 1, context);
                        }
                      },
                      child: Icon(
                        Icons.favorite,
                        color: isLike == true
                            ? AppColor.primaryColor
                            : AppColor.whiteColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          widget.listImage.isEmpty
              ? Container(
                  height: 150,
                  width: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                    ),
                  ),
                )
              : CarouselSlider(
                  items: imgList
                      .map(
                        (item) => Container(
                          height: 150,
                          width: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.image),
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
