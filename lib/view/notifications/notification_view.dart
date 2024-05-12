import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/view/notifications/Widgets/notification_widget.dart';
import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

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
            shrinkWrap: true,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const VerticalSpeacing(30.0),
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
                        'Notifications',
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
                  GridView.count(
                    padding:
                        const EdgeInsets.all(10.0), // Padding around the grid
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 1, // One card per row
                    childAspectRatio: (MediaQuery.of(context).size.width /
                        120), // Adjust width based on screen size
                    mainAxisSpacing: 16.0, // Spacing between rows
                    crossAxisSpacing: 0.0, // Spacing between columns
                    children: List.generate(
                        10,
                        (index) => const SizedBox(
                            height: 100.0,
                            child: NotificationWidget())), // Wrap in Container
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
