import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import '../../../../res/components/colors.dart';
import '../../../res/components/vertical_spacing.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard(
      {super.key,
      required this.profilePic,
      required this.name,
      required this.rating,
      required this.time,
      required this.comment});
  final String profilePic;
  final String name;
  final String rating;
  final DateTime time;
  final String comment;
  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  String addEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    double doublereview = double.parse(widget.rating);
    DateTime now = widget.time;
    String formattedDate = DateFormat("E, d'th' MMM '").format(now);
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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      ),
                      foregroundImage: NetworkImage(widget.profilePic),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addEllipsis(
                            widget.name.toString(),
                            12, // Maximum length before adding ellipsis
                          ),
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textColor1,
                          ),
                        ),
                        RatingBar.builder(
                            initialRating: doublereview,
                            minRating: 1,
                            allowHalfRating: true,
                            glowColor: Colors.amber,
                            itemCount: 5,
                            itemSize: 18,
                            ignoreGestures: true,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            itemBuilder: (context, _) => const Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber,
                                ),
                            onRatingUpdate: (rating) {}),
                      ],
                    ),
                  ],
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.cardTxColor,
                  ),
                ),
              ],
            ),
            const VerticalSpeacing(8),
            Text(
              widget.comment,
              style: const TextStyle(
                fontFamily: 'CenturyGothic',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColor.cardTxColor,
              ),
            ),
            const VerticalSpeacing(14),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  color: AppColor.primaryColor,
                ),
                Text(
                  "24 Like",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.cardTxColor,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.reply_outlined,
                  color: AppColor.cardTxColor,
                ),
                Text(
                  "Reply",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.cardTxColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
