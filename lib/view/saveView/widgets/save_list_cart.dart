import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';

class SaveListCart extends StatelessWidget {
  const SaveListCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                image: const DecorationImage(
                    image: AssetImage('images/cartImg.png'),
                    fit: BoxFit.contain),
              ),
              // child: Image.asset('images/cartImg.png'),
            ),
            title: const Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      textAlign: TextAlign.start,
                      TextSpan(
                        text: 'Dried figs\n',
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColor.cardTxColor,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '⭐ 4.5\n',
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 14.0,
                            ),
                          ),
                          TextSpan(
                            text: '\$10',
                            style: TextStyle(
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
                  onTap: () {},
                  child: const Icon(
                    Icons.delete_outline,
                    color: AppColor.appBarTxColor,
                    size: 24,
                  ),
                ),
                InkWell(
                  onTap: () {},
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
