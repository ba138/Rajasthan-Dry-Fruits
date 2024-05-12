import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rjfruits/view/total_review/widgets/review_card.dart';

import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';

class TotalRatingScreen extends StatefulWidget {
  const TotalRatingScreen({
    super.key,
  });
  @override
  State<TotalRatingScreen> createState() => _TotalRatingScreenState();
}

class _TotalRatingScreenState extends State<TotalRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.west,
              color: AppColor.textColor1,
            )),
        title: const Text(
          "Reviews",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.textColor1,
          ),
        ),
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
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    color: AppColor.primaryColor,
                    child: const Center(
                      child: Text(
                        "4.5",
                        style: TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpeacing(10),
                  const Text(
                    "320 reviews",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                    ],
                  ),
                  const VerticalSpeacing(20.0),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "5 stars",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                            ),
                          ),
                          LinearPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            width: MediaQuery.of(context).size.width / 1.5,
                            percent: 0.8,
                            progressColor: AppColor.primaryColor,
                            backgroundColor: Colors.grey.shade300,
                          ),
                          const Text(
                            "200",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "4 stars",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                            ),
                          ),
                          LinearPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            width: MediaQuery.of(context).size.width / 1.5,
                            percent: 0.7,
                            progressColor: AppColor.primaryColor,
                            backgroundColor: Colors.grey.shade300,
                          ),
                          const Text(
                            "150",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "3 stars ",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                            ),
                          ),
                          LinearPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            width: MediaQuery.of(context).size.width / 1.5,
                            percent: 0.6,
                            progressColor: AppColor.primaryColor,
                            backgroundColor: Colors.grey.shade300,
                          ),
                          const Text(
                            "90",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "2 stars",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                            ),
                          ),
                          LinearPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            width: MediaQuery.of(context).size.width / 1.5,
                            percent: 0.5,
                            progressColor: AppColor.primaryColor,
                            backgroundColor: Colors.grey.shade300,
                          ),
                          const Text(
                            "30",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "1 stars",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                            ),
                          ),
                          LinearPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            width: MediaQuery.of(context).size.width / 1.5,
                            percent: 0.4,
                            progressColor: AppColor.primaryColor,
                            backgroundColor: Colors.grey.shade300,
                          ),
                          const Text(
                            "10",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.cardTxColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              const ReviewCard(
                  profilePic:
                      'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
                  name: 'Hasnain',
                  rating: 'rating',
                  time: '12:50pm',
                  comment:
                      'Aliqua officia duis occaecat consectetur fugiat nostrud anim dolor commodo officia proident. Voluptate nisi reprehenderit.'),
            ],
          ),
        ),
      ),
    );
  }
}
