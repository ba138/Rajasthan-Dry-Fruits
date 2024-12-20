import 'package:flutter/material.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/HomeView/filter_view.dart';
import 'package:rjfruits/view/HomeView/home_view.dart';
import 'package:rjfruits/view/authView/forget_password_view.dart';
import 'package:rjfruits/view/authView/login_view.dart';
import 'package:rjfruits/view/bestSellersView/best_sellers.dart';
import 'package:rjfruits/view/cart/cart_page.dart';
import 'package:rjfruits/view/contacts/contact_us.dart';
import 'package:rjfruits/view/dashBoard/dashboard.dart';
import 'package:rjfruits/view/authView/register_view.dart';
import 'package:rjfruits/view/discountProdView/discount_prod_view.dart';
import 'package:rjfruits/view/notifications/notification_view.dart';
import 'package:rjfruits/view/onboardingViews/onboarding_view1.dart';
import 'package:rjfruits/view/onboardingViews/onboarding_view2.dart';
import 'package:rjfruits/view/onboardingViews/onboarding_view3.dart';
import 'package:rjfruits/view/onboardingViews/splash_screen.dart';
import 'package:rjfruits/view/orders/cancel_order_view.dart';
import 'package:rjfruits/view/popularItemsView/popularItems_view.dart';
import 'package:rjfruits/view/profileView/promo_view.dart';
import 'package:rjfruits/view/rating/widget/my_rating.dart';
import 'package:rjfruits/view/search/search_view.dart';
import 'package:rjfruits/view/profileView/delivery_address_view.dart';
import 'package:rjfruits/view/shopView/shop_view.dart';
import '../../view/orders/myorders.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());
      case RoutesName.onboarding1:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnBoardingScreen1());
      case RoutesName.onboarding2:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnBoardingScreen2());
      case RoutesName.onboarding3:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnBoardingScreen3());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.dashboard:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashBoardScreen());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterView());
      case RoutesName.forget:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgetPasswordScreen(),
        );

      case RoutesName.bestSellers:
        return MaterialPageRoute(
          builder: (BuildContext context) => const BestSellers(),
        );
      case RoutesName.popularItems:
        return MaterialPageRoute(
          builder: (BuildContext context) => const PopularItems(),
        );
      case RoutesName.discountProd:
        return MaterialPageRoute(
          builder: (BuildContext context) => const DisCountProd(),
        );
      case RoutesName.shopView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ShopView(),
        );
      // case RoutesName.checkOut:
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const CheckOutScreen(),
      //   );
      case RoutesName.promoView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const PromoView(),
        );
      case RoutesName.cartView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const CartView(),
        );

      case RoutesName.notificationView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const NotificationView(),
        );

      // case RoutesName.paymentDone:
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => PaymentDoneScreen(),
      //   );

      case RoutesName.searchView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SearchView(),
        );
      case RoutesName.deliveryAddress:
        return MaterialPageRoute(
          builder: (BuildContext context) => const DeliveryAddressScreen(),
        );
      case RoutesName.filter:
        return MaterialPageRoute(
          builder: (BuildContext context) => const FilterScreen(),
        );

      case RoutesName.myorders:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MyOrders());

      case RoutesName.myRating:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MyRating());
      case RoutesName.cancelOrder:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CancelOrderScreen());

      case RoutesName.contactUs:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ContactUs());
      // case RoutesName.totalReviews:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const TotalRatingScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No routes define'),
            ),
          );
        });
    }
  }
}
