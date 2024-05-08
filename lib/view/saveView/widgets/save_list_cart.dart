import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:rjfruits/view_model/product_detail_view_model.dart';
import 'package:rjfruits/view_model/save_view_model.dart';
import '../../../res/components/colors.dart';

class SaveListCart extends StatefulWidget {
  const SaveListCart({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.id,
    required this.onpress,
  });
  final String name;
  final String price;
  final String image;
  final String id;
  final VoidCallback onpress;

  @override
  State<SaveListCart> createState() => _SaveListCartState();
}

class _SaveListCartState extends State<SaveListCart> {
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
  Widget build(BuildContext context) {
    ProductRepositoryProvider proRepoProvider =
        Provider.of<ProductRepositoryProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: ListTile(
            leading: Container(
              height: 70.0,
              width: 75.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1, color: AppColor.primaryColor),
                image: DecorationImage(
                    image: NetworkImage(widget.image), fit: BoxFit.contain),
              ),
              // child: Image.asset('images/cartImg.png'),
            ),
            title: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      textAlign: TextAlign.start,
                      TextSpan(
                        text: '${widget.name}\n',
                        style: const TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColor.cardTxColor,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: '⭐ 4.5\n',
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 14.0,
                            ),
                          ),
                          TextSpan(
                            text: '\$${widget.price}',
                            style: const TextStyle(
                              color: AppColor.appBarTxColor,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: widget.onpress,
                  child: const Icon(
                    Icons.delete_outline,
                    color: AppColor.appBarTxColor,
                    size: 24,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Future<bool> isInCart =
                        proRepoProvider.isProductInCart(widget.id);
                    if (await isInCart) {
                      Utils.toastMessage("Product is already in the cart");
                    } else {
                      proRepoProvider.saveCartProducts(widget.id, widget.name,
                          widget.image, widget.price, 1);
                    }
                  },
                  child: const ImageIcon(
                    AssetImage(
                      'images/ds.png',
                    ),
                    color: AppColor.appBarTxColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
