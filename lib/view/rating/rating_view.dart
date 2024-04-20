import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
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
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              "https://proflowers.pk/wp-content/uploads/2022/09/2-kg-mixed-dry-fruits.jpg"),
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
                          initialRating: 3,
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
                          onRatingUpdate: (rating) {},
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
                            // controller: _controller,
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
                          child: RoundedButton(title: "Submit", onpress: () {}),
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
