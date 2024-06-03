// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/model/order_detailed_model.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:rjfruits/view/orders/widgets/prod_detail_widget.dart';
import 'package:rjfruits/view_model/service/track_order_view_model.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

import '../../../res/components/colors.dart';
import '../../../res/components/vertical_spacing.dart';

class TrackOrder extends StatefulWidget {
  final OrderDetailedModel orderDetailModel;
  final String? shipRocketId;
  final String customShipId;
  const TrackOrder(
      {super.key,
      required this.orderDetailModel,
      required this.shipRocketId,
      required this.customShipId});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  List<TextDto> orderList = [];

  final bool isTrue = true;
  Future<void> _getUserData() async {
    try {
      // Fetch the user preferences without listening to changes
      final userPreferences =
          Provider.of<UserViewModel>(context, listen: false);
      final userModel = await userPreferences.getUser();
      final token = userModel.key;

      // Ensure widget.shipRocketId is handled correctly as a String
      final shipRocketId = widget.shipRocketId;
      final customShipId = widget.customShipId.toString();

      // Debug print the IDs to verify their values
      debugPrint('shipRocketId: $shipRocketId');
      debugPrint('customShipId: $customShipId');

      // Determine which API call to make based on the presence of shipRocketId
      if (shipRocketId == null || shipRocketId.isEmpty) {
        debugPrint('Calling customShip with customShipId: $customShipId');
        await Provider.of<TrackOrderRepositoryProvider>(context, listen: false)
            .customShip(customShipId, token);
      } else {
        debugPrint('Calling fetchShipData with shipRocketId: $shipRocketId');
        await Provider.of<TrackOrderRepositoryProvider>(context, listen: false)
            .fetchShipData(shipRocketId, token);
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final trackOrder =
        Provider.of<TrackOrderRepositoryProvider>(context, listen: false);
    debugPrint("this is ship id${widget.shipRocketId}");
    DateTime now = widget.orderDetailModel.createdOn;
    String formattedDate = DateFormat("E, d'th' MMM ''yy - hh:mma").format(now);
    orderList.clear();
    orderList.insert(
      0,
      TextDto("Your order has been placed", formattedDate),
    );

    String addEllipsis(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      } else {
        return '${text.substring(0, maxLength)}...';
      }
    }

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          image: DecorationImage(
              image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20,
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
                      addEllipsis(
                        widget.orderDetailModel.orderItems[0].product.id
                            .toString(),
                        20, // Maximum length before adding ellipsis
                      ),
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ],
                ),
                OrderTracker(
                  status: Status.delivered,
                  activeColor: AppColor.primaryColor,
                  inActiveColor: Colors.grey[300],
                  orderTitleAndDateList: orderList,
                  subDateTextStyle: const TextStyle(
                    color: AppColor.textColor1,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                  shippedTitleAndDateList:
                      trackOrder.trackOrderRepositoryProvider.shippedList,
                  outOfDeliveryTitleAndDateList:
                      trackOrder.trackOrderRepositoryProvider.outOfDeliveryList,
                  deliveredTitleAndDateList:
                      trackOrder.trackOrderRepositoryProvider.deliveredList,
                  headingDateTextStyle:
                      const TextStyle(color: Colors.transparent),
                ),
                const Text(
                  'Delivery Details',
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.blackColor,
                  ),
                ),
                const VerticalSpeacing(12.0),

                Text(
                  'CourierName: ${trackOrder.trackOrderRepositoryProvider.deliveryCompany}',
                  style: const TextStyle(
                    color: AppColor.textColor1,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                const VerticalSpeacing(12.0),

                Text(
                  'Destination: ${trackOrder.trackOrderRepositoryProvider.destination}',
                  style: const TextStyle(
                    color: AppColor.textColor1,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TrackingId: ${addEllipsis(
                        trackOrder.trackOrderRepositoryProvider.trackingId
                            .toString(),
                        30, // Maximum length before adding ellipsis
                      )}',
                      style: const TextStyle(
                        color: AppColor.textColor1,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: trackOrder
                                  .trackOrderRepositoryProvider.trackingId));
                          Utils.toastMessage("Text copied to clipboard");
                        },
                        icon: const Icon(
                          Icons.copy,
                          size: 18,
                        ))
                  ],
                ),

                const VerticalSpeacing(30.0),

                const Text(
                  'Product Details',
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.blackColor,
                  ),
                ),
                const VerticalSpeacing(30.0),

                // This is not favourite list card but i use it in order track in Prodcut details
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.4,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.orderDetailModel.orderItems.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 16,
                      ); // Adjust the height as needed
                    },
                    itemBuilder: (context, index) {
                      final data =
                          widget.orderDetailModel.orderItems[index].product;
                      final weight = widget.orderDetailModel.orderItems[index]
                              .productWeight?.weight.name ??
                          "1kg";
                      return ProductDetailsWidget(
                        img: data.thumbnailImage,
                        title: addEllipsis(
                          data.title.toString(),
                          12, // Maximum length before adding ellipsis
                        ),
                        subTitle: 'From The Farmer',
                        price: weight.toString(),
                        productPrice: '₹${data.price.toString()}',
                        procustAverate:
                            '${widget.orderDetailModel.orderItems[index].qty}X',
                        id: '',
                        productId: '',
                      );
                    },
                  ),
                ),

                const VerticalSpeacing(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
