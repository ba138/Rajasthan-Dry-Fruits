// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:provider/provider.dart';

import 'package:rjfruits/model/order_detailed_model.dart';
import 'package:rjfruits/view/orders/widgets/prod_detail_widget.dart';
import 'package:rjfruits/view_model/service/track_order_view_model.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

import '../../../res/components/colors.dart';
import '../../../res/components/vertical_spacing.dart';
import '../../../utils/routes/routes_name.dart';

class TrackOrder extends StatefulWidget {
  final OrderDetailedModel orderDetailModel;
  const TrackOrder({
    super.key,
    required this.orderDetailModel,
  });

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  List<TextDto> orderList = [
    TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
    TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
    TextDto("Your item has been picked up by courier partner.",
        "Tue, 29th Mar '22 - 5:00pm"),
  ];

  List<TextDto> shippedList = [
    TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
    TextDto("Your item has been received in the nearest hub to you.", null),
  ];

  List<TextDto> outOfDeliveryList = [
    TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
  ];

  List<TextDto> deliveredList = [
    TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
  ];
  final bool isTrue = true;
  getAllTheData() async {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);
    final userModel =
        await userPreferences.getUser(); // Await the Future<UserModel> result
    final token = userModel.key;
    Provider.of<TrackOrderRepositoryProvider>(context, listen: false)
        .fetchOrderDetails(context, "3", token);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'My Order Details ',
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.blackColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.blackColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppColor.whiteColor,
            image: DecorationImage(
                image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpeacing(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.orderDetailModel.orderItems[0].product.id
                          .toString(),
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.cancelOrder,
                        );
                      },
                      child: Container(
                        height: 32,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: AppColor.primaryColor,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Center(
                            child: Text(
                              'Cancel order',
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: OrderTracker(
                    status: Status.delivered,
                    activeColor: AppColor.primaryColor,
                    inActiveColor: Colors.grey[300],
                    orderTitleAndDateList: orderList,
                    shippedTitleAndDateList: shippedList,
                    outOfDeliveryTitleAndDateList: outOfDeliveryList,
                    deliveredTitleAndDateList: deliveredList,
                  ),
                ),
                const Text(
                  '   Product Details',
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.blackColor,
                  ),
                ),
                const VerticalSpeacing(10.0),
                // This is not favourite list card but i use it in order track in Prodcut details
                const ProductDetailsWidget(
                  img: 'images/cartImg.png',
                  title: 'Arnotts grans',
                  subTitle: 'Form The Farmer',
                  price: '3 KG',
                  productPrice: '\$30',
                  procustAverate: '3x',
                  id: '',
                  productId: '',
                ),
                const VerticalSpeacing(10.0),
                const ProductDetailsWidget(
                  img: 'images/cartImg.png',
                  title: 'cauliflower',
                  subTitle: 'Form The Farmer',
                  price: '5 KG',
                  productPrice: '\$20',
                  procustAverate: '6x',
                  id: '',
                  productId: '',
                ),
                const VerticalSpeacing(10.0),
                const ProductDetailsWidget(
                  img: 'images/cartImg.png',
                  title: 'girlGuide',
                  subTitle: 'Form The Farmer',
                  price: '2 KG',
                  productPrice: '\$80',
                  procustAverate: '9x',
                  id: '',
                  productId: '',
                ),

                const VerticalSpeacing(30.0),
                const ListTile(
                  title: Text(
                    'Total Amount',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ),
                  trailing: Text(
                    '\$130',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                const ListTile(
                  title: Text(
                    'Paid From',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ),
                  trailing: Text(
                    'Credit Card',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
