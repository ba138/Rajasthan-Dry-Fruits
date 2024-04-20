import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
  });

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
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListTile(
          leading: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(color: AppColor.primaryColor),
            child: Center(
                child: ImageIcon(
              AssetImage(
                'images/notification.png',
              ),
              color: AppColor.whiteColor,
            )),
          ),
          title: const Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text.rich(
                      textAlign: TextAlign.start,
                      TextSpan(
                        text: 'Gifts Offer\n',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.cardTxColor,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Hot Deal Buy one get free one\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                              fontSize: 12.0,
                            ),
                          ),
                          TextSpan(
                            text: 'Offer Hery...\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                              fontSize: 12.0,
                            ),
                          ),
                          TextSpan(
                            text: 'Now',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColor.cardTxColor,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
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
