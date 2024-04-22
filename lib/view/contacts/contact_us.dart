import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/checkOut/widgets/Payment_field.dart';
import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

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
          child: ListView(
            children: [
              Column(
                children: [
                  const VerticalSpeacing(10.0),
                  Row(
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
                      const SizedBox(width: 80.0),
                      Text(
                        'Contact Us',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.appBarTxColor,
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
                      border:
                          Border.all(color: AppColor.primaryColor, width: 1),
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
                              const PaymentField(
                                maxLines: 2,
                                text: 'Name',
                              ),
                              const PaymentField(
                                maxLines: 2,
                                text: 'Email',
                              ),
                              const PaymentField(
                                maxLines: 2,
                                text: 'Mobile Number',
                              ),
                              const PaymentField(
                                maxLines: 2,
                                text: 'Address',
                              ),
                              const VerticalSpeacing(20.0),
                              RoundedButton(
                                  title: 'Submit',
                                  onpress: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.viewProfile);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpeacing(10.0),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColor.primaryColor, width: 1),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              color: AppColor.primaryColor,
                              child: const Center(
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                            title: const Text(
                              '26/C new hussainabad',
                              style: TextStyle(
                                  fontSize: 14, color: AppColor.cardTxColor),
                            ),
                            subtitle: const Text(
                              'Rajesthani dry fruits ',
                              style: TextStyle(
                                  fontSize: 14, color: AppColor.cardTxColor),
                            ),
                          ),
                          const VerticalSpeacing(15.0),
                          Container(
                            height: 95,
                            width: 294,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/location.png'),
                                    fit: BoxFit.contain)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpeacing(30.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
