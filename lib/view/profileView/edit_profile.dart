// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/view/checkOut/widgets/Payment_field.dart';

import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';

class EditProfile extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  const EditProfile({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    firstNameController = TextEditingController(
      text: widget.firstName,
    );
    lastNameController = TextEditingController(
      text: widget.lastName,
    );
    emailController = TextEditingController(
      text: widget.email,
    );
  }

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
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
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
                    Text(
                      'Edit Profile',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.transparent,
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
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PaymentField(
                              controller: firstNameController,
                              maxLines: 2,
                              text: 'First Name',
                              hintText: 'Hiren user',
                            ),
                            PaymentField(
                              controller: lastNameController,
                              maxLines: 2,
                              text: 'Last Name',
                              hintText: 'user',
                            ),
                            PaymentField(
                              controller: emailController,
                              maxLines: 2,
                              text: 'Email',
                              hintText: 'Example@gmail.com',
                            ),
                            const VerticalSpeacing(60.0),
                            RoundedButton(
                                title: 'Save',
                                onpress: () {
                                  Navigator.pop(context);
                                }),
                            const VerticalSpeacing(20.0),
                          ],
                        ),
                      ],
                    ),
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
