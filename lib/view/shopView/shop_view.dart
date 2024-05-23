import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/HomeView/widgets/homeCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/view_model/shop_view_model.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  @override
  void initState() {
    Provider.of<ShopRepositoryProvider>(context, listen: false).getShopProd(
      context,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final shopRepositoryProvider = Provider.of<ShopRepositoryProvider>(context);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          image: DecorationImage(
              image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const VerticalSpeacing(30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.transparent,
                        ),
                      ),
                      Text(
                        'Shop',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.appBarTxColor,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.searchView);
                        },
                        child: Container(
                          height: 31,
                          width: 35,
                          decoration: BoxDecoration(
                            color: AppColor.boxColor,
                            borderRadius: BorderRadius.circular(
                              4,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.search,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10.0),
                      Text.rich(
                        textAlign: TextAlign.start,
                        TextSpan(
                          text:
                              '${shopRepositoryProvider.shopRepository.shopProducts.length} Fund Items ',
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: AppColor.cardTxColor,
                              fontWeight: FontWeight.w600),
                          children: const [
                            TextSpan(
                              text: 'Fresh Fruit Dry Fruit',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Consumer<ShopRepositoryProvider>(
                    builder: (context, shopRepositoryProvider, _) {
                      return GridView.count(
                        padding: const EdgeInsets.all(
                            5.0), // Add padding around the grid
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: (180 / 255),
                        mainAxisSpacing: 10.0, // Spacing between rows
                        crossAxisSpacing: 10.0, // Spacing between columns
                        children: List.generate(
                          shopRepositoryProvider
                              .shopRepository.shopProducts.length,
                          (index) => HomeCard(
                            isdiscount: false,
                            title: shopRepositoryProvider
                                .shopRepository.shopProducts[index].title,
                            image: shopRepositoryProvider.shopRepository
                                .shopProducts[index].thumbnailImage,
                            discount: shopRepositoryProvider
                                .shopRepository.shopProducts[index].discount
                                .toString(),
                            proId: shopRepositoryProvider
                                .shopRepository.shopProducts[index].id,
                            price: shopRepositoryProvider
                                .shopRepository.shopProducts[index].price,
                            averageReview: shopRepositoryProvider.shopRepository
                                .shopProducts[index].averageReview
                                .toString(),
                            // Pass other data properties here
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
