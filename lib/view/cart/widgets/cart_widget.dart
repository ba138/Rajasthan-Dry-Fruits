import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import '../../../res/components/colors.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({
    super.key,
  });
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.primaryColor, width: 1),
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
      height: 120,
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text.rich(
                      textAlign: TextAlign.start,
                      TextSpan(
                        text: '\nDried figs\n',
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColor.cardTxColor,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '⭐ 4.5',
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpeacing(10.0),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.textColor1,
                              ),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          '2KG',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textColor1,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.textColor1,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
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
                const Text(
                  '\$20',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textColor1,
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
