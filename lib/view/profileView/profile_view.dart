// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/profileView/view_profile.dart';
import 'package:rjfruits/view_model/home_view_model.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';
import '../../view_model/service/auth_services.dart';
import 'widgets/profile_center_btn.dart';
import 'widgets/profile_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final double tHeight = 200.0;
  final double top = 130.0;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: const Text(
          'Profile ',
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.west,
          color: Colors.transparent,
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  _buildCoverBar(),
                  Positioned(
                    top: 1.0,
                    left: MediaQuery.of(context).size.width / 2.5,
                    child: _buildProfile(
                        '${userData['first_name']}', '${userData['pk']}'),
                  ),
                  Positioned(
                    top: tHeight - top / 2 - 10,
                    child: _builProfileContainer(),
                  ),
                ],
              ),
              const VerticalSpeacing(55.0),
              _buildProfileFeatures('${userData['first_name']}',
                  '${userData['last_name']}', '${userData['email']}'),
            ],
          ),
        ),
      ),
    );
  }

  _buildCoverBar() {
    return Container(
      height: tHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
        color: AppColor.primaryColor,
      ),
    );
  }

  _buildProfile(String? name, String? id) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Stack(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                  'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'),
            ),
          ],
        ),
        Text(
          name ?? "Wait..",
          style: const TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.whiteColor,
          ),
        ),
        Text(
          id != null ? "ID:$id" : "Wait",
          style: const TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.whiteColor,
          ),
        ),
      ],
    );
  }

  _builProfileContainer() {
    return Container(
      height: top,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColor.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          profileCenterBtns(
            ontap: () {
              Navigator.pushNamed(context, RoutesName.myorders);
            },
            tColor: const Color(0xff6AA9FF),
            bColor: const Color(0xff005AD5),
            icon: Icons.local_shipping_outlined,
            title: 'My All',
            subtitle: 'Order',
          ),
          profileCenterBtns(
            ontap: () {
              // Navigator.pushNamed(context, RoutesName.promosOffer);
            },
            tColor: const Color(0xffFF6A9F),
            bColor: const Color(0xffD50059),
            icon: Icons.card_giftcard_outlined,
            title: 'Offer &',
            subtitle: 'Promos',
          ),
          profileCenterBtns(
            ontap: () {
              Navigator.pushNamed(context, RoutesName.deliveryAddress);
            },
            tColor: const Color(0xff6DF5FC),
            bColor: const Color(0xff3CB6BB),
            icon: Icons.home_outlined,
            title: 'Delivery',
            subtitle: 'Address',
          ),
        ],
      ),
    );
  }

  _buildProfileFeatures(String? firstName, String? lastName, String? email) {
    final AuthService authService = AuthService();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.42,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.primaryColor, width: 1),
          color: const Color.fromRGBO(255, 255, 255, 0.2),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              blurRadius: 2,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                children: [
                  ProfileWidgets(
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => ViewProfile(
                                      firstname: firstName,
                                      lastName: lastName,
                                      email: email,
                                    )));
                      },
                      tColor: const Color(0xff6DF5FC),
                      bColor: const Color(0xff46C5CA),
                      icon: Icons.person_outline,
                      trIcon: Icons.arrow_forward_ios,
                      title: 'My Profile'),
                  const Divider(),
                  ProfileWidgets(
                      ontap: () {
                        Navigator.pushNamed(context, RoutesName.contactUs);
                      },
                      tColor: const Color(0xffCDFF9D),
                      bColor: const Color(0xff40C269),
                      icon: Icons.notifications_outlined,
                      trIcon: Icons.arrow_forward_ios,
                      title: 'Contact Us'),
                  const Divider(),
                  ProfileWidgets(
                      ontap: () {
                        Navigator.pushNamed(context, RoutesName.myRating);
                      },
                      tColor: const Color(0xffDF9EF5),
                      bColor: const Color(0xffA24ABF),
                      icon: Icons.settings_outlined,
                      trIcon: Icons.arrow_forward_ios,
                      title: 'My Rating'),
                  const Divider(),
                  ProfileWidgets(
                    ontap: () async {
                      await authService.logout(context);
                    },
                    tColor: const Color(0xffFF9CCB),
                    bColor: const Color(0xffEC4091),
                    icon: Icons.logout_outlined,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'Log Out',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
