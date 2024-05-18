// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rjfruits/view_model/save_view_model.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    super.key,
    required this.image,
    required this.listImage,
    required this.id,
    required this.name,
    required this.discount,
  });

  final String image;
  final List<String> listImage;
  final String id;
  final String name;
  final String discount;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imgList = [];
  int currentIndex = 0;
  Color loveColor = AppColor.whiteColor;

  void checkProduct() async {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);
    final userModel = await userPreferences.getUser();
    final token = userModel.key;

    SaveProductRepositoryProvider homeRepoProvider =
        Provider.of<SaveProductRepositoryProvider>(context, listen: false);
    await homeRepoProvider.getCachedProducts(context, token);

    bool isInCart = await homeRepoProvider.isProductInCart(widget.id);
    setState(() {
      loveColor = isInCart ? AppColor.primaryColor : AppColor.whiteColor;
    });
  }

  @override
  void initState() {
    checkProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);
    imgList = widget.listImage;

    SaveProductRepositoryProvider saveRepo =
        Provider.of<SaveProductRepositoryProvider>(context, listen: false);

    return Container(
      height: 270,
      width: MediaQuery.of(context).size.width * 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.primaryColor, width: 2),
        color: const Color.fromRGBO(255, 255, 255, 0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          const VerticalSpeacing(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.boxColor,
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        final userModel = await userPreferences.getUser();
                        final token = userModel.key;

                        saveRepo.saveRepository
                            .getCachedProducts(context, token);

                        String? deleteId;
                        if (saveRepo.saveRepository.saveList.isNotEmpty) {
                          final itemToDelete =
                              saveRepo.saveRepository.saveList.firstWhere(
                            (item) => item["product"]["id"] == widget.id,
                          );
                          deleteId = itemToDelete["id"].toString();
                        }

                        if (deleteId != null) {
                          await saveRepo.deleteProduct(
                              deleteId, context, token);
                          setState(() {
                            loveColor = AppColor.whiteColor;
                          });
                        } else {
                          saveRepo.saveCartProducts(
                            widget.id,
                            widget.name,
                            widget.image,
                            widget.discount,
                            1,
                            context,
                            token,
                          );
                          setState(() {
                            loveColor = AppColor.primaryColor;
                          });
                        }
                      },
                      child: Icon(
                        Icons.favorite,
                        color: loveColor,
                      ),
                    ),
                  ),
                ),
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
                              image: NetworkImage(item),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imgList.length, (index) {
              return Container(
                height: 5,
                width: currentIndex == index ? 18 : 10,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? AppColor.primaryColor
                      : const Color(0xff898989),
                  borderRadius: BorderRadius.circular(30),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
