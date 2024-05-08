import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/view/saveView/widgets/save_list_cart.dart';
import 'package:rjfruits/view_model/save_view_model.dart';
import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';

class SaveView extends StatefulWidget {
  const SaveView({super.key});

  @override
  State<SaveView> createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  @override
  void initState() {
    super.initState();
    Provider.of<SaveProductRepositoryProvider>(context, listen: false)
        .getCachedProducts();
  }

  @override
  Widget build(BuildContext context) {
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
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.west,
                          color: AppColor.appBarTxColor,
                        ),
                      ),
                      const SizedBox(width: 80.0),
                      Text(
                        'Save Items',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.appBarTxColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: Consumer<SaveProductRepositoryProvider>(
                      builder: (context, cartRepoProvider, child) {
                        List<Map<String, dynamic>> cartItems =
                            cartRepoProvider.saveRepository.saveList;

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            if (index < cartItems.length) {
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: SaveListCart(
                                    onpress: () {
                                      Provider.of<SaveProductRepositoryProvider>(
                                              context,
                                              listen: false)
                                          .deleteProduct(
                                              cartItems[index]['productId']);
                                      Provider.of<SaveProductRepositoryProvider>(
                                              context,
                                              listen: false)
                                          .getCachedProducts();
                                    },
                                    name: cartItems[index]['name'],
                                    price: cartItems[index]['price'],
                                    image: cartItems[index]['image'],
                                    id: cartItems[index]['productId'],
                                  ));
                            } else {
                              return const SizedBox.shrink(
                                child: Center(
                                  child: Text("No Products to Show"),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
