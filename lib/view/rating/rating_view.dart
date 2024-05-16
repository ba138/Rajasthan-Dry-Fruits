// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view_model/home_view_model.dart';
import 'package:rjfruits/view_model/rating_view_model.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

class RatingScreen extends StatefulWidget {
  final String prodId;
  final String img;
  final int order;
  const RatingScreen({
    super.key,
    required this.prodId,
    required this.img,
    required this.order,
  });

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double initalRating = 3;
  TextEditingController commentController = TextEditingController();
  Map userData = {};

  String token = "";

  Future<void> _getUserData() async {
    try {
      final userPreferences =
          Provider.of<UserViewModel>(context, listen: false);
      final userModel = await userPreferences.getUser();
      // Await the Future<UserModel> result
      token = userModel.key;
      final userData =
          await Provider.of<HomeRepositoryProvider>(context, listen: false)
              .getUserData(token);
      setState(() {
        this.userData = userData;
      });
      debugPrint("this is the cliecnt details:$userData");
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }

  void postRating() async {
    try {
      String rating = initalRating.toString();
      double doubleRating = double.parse(rating); // Parse as double

      int intRating = doubleRating.round(); // Convert to int by rounding

      final userPreferences =
          Provider.of<UserViewModel>(context, listen: false);

      final userModel =
          await userPreferences.getUser(); // Await the Future<UserModel> result
      final token = userModel.key;

      Provider.of<RatingRepositoryProvider>(context, listen: false).rating(
        intRating,
        widget.prodId,
        commentController.text,
        context,
        token,
        userData['pk'],
        widget.order,
      );
    } catch (e) {
      debugPrint("Error parsing rating: $e");
      // Handle error appropriately, e.g., show an error message to the user
    }
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.west,
            color: AppColor.textColor1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "My Rating",
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.textColor1,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppColor.whiteColor,
            image: DecorationImage(
                image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const VerticalSpeacing(20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColor.primaryColor, width: 2),
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
                    child: Column(
                      children: [
                        const VerticalSpeacing(20),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(widget.img),
                        ),
                        const VerticalSpeacing(20),
                        Text(
                          "dryfruit of mix fresh of new\n and organic",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                        const VerticalSpeacing(20),
                        Text(
                          "How would you rate the\nquality of this Products",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                        const VerticalSpeacing(24),
                        RatingBar.builder(
                          initialRating: initalRating,
                          minRating: 1,
                          unratedColor: AppColor.boxColor,
                          allowHalfRating: true,
                          glowColor: Colors.amber,
                          itemCount: 5,
                          itemSize: 40,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_rate_rounded,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            initalRating = rating;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "How would you rate the\nquality of this Products",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  "Poppins",
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.textColor1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: TextField(
                            controller: commentController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null, // Allows unlimited number of lines
                            decoration: InputDecoration(
                              hintStyle: GoogleFonts.getFont(
                                "Poppins",
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.nextColor,
                                ),
                              ),
                              hintText:
                                  'Irure velit sunt cupidatat nulla exercitation\n Lorem sint in ut eiusmod nisi. Fugiat sint eli\nt do irure ex ex magna enim enim labore a\nd mollit adipisicing veniam. ',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.nextColor,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(
                                bottom: 16.0,
                                left: 14,
                                right: 14,
                              ),
                            ),
                          ),
                        ),
                        const VerticalSpeacing(40),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: RoundedButton(
                              title: "Submit",
                              onpress: () {
                                postRating();
                              }),
                        ),
                        const VerticalSpeacing(40),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
