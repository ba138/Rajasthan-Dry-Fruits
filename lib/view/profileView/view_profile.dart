// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/profileView/edit_profile.dart';

import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';

class ViewProfile extends StatelessWidget {
  final String? firstname;
  final String? lastName;
  final String? email;
  const ViewProfile({
    super.key,
    this.firstname,
    this.lastName,
    this.email,
  });

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
          child: Column(
            children: [
              const VerticalSpeacing(30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    'Pofile',
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColor.appBarTxColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => EditProfile(
                              firstName: firstname!,
                              lastName: lastName!,
                              email: email!),
                        ),
                      );
                    },
                    child: Text(
                      'Edit Profile',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const VerticalSpeacing(30.0),
              Container(
                height: MediaQuery.of(context).size.height / 1.2,
                width: double.infinity,
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        textAlign: TextAlign.start,
                        TextSpan(
                          text: 'First Name\n\n',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.cardTxColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: firstname,
                              style: const TextStyle(
                                color: AppColor.textColor1,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalSpeacing(20.0),
                      Text.rich(
                        textAlign: TextAlign.start,
                        TextSpan(
                          text: 'Last Name\n\n',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.cardTxColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: lastName,
                              style: const TextStyle(
                                color: AppColor.textColor1,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalSpeacing(20.0),
                      Text.rich(
                        textAlign: TextAlign.start,
                        TextSpan(
                          text: 'Email\n\n',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.cardTxColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: email,
                              style: const TextStyle(
                                color: AppColor.textColor1,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalSpeacing(20.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
