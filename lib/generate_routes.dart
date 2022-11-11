import 'package:berhentikok/base/page_arguments.dart';
import 'package:berhentikok/page/achievement/achievement_page.dart';
import 'package:berhentikok/page/consumption/consumption_page.dart';
import 'package:berhentikok/page/finance/finance_page.dart';
import 'package:berhentikok/page/health/health_page.dart';
import 'package:berhentikok/page/home/home_page.dart';
import 'package:berhentikok/page/on_boarding/on_boarding_page.dart';
import 'package:berhentikok/page/statistic/statistic_page.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnBoardingPage.routeName:
        return MaterialPageRoute(builder: (context) => const OnBoardingPage());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case StatisticPage.routeName:
        return MaterialPageRoute(builder: (context) => const StatisticPage());
      case HealthPage.routeName:
        final args = settings.arguments as HealthArguments;
        return MaterialPageRoute(
          builder: (context) => HealthPage(
            healthProgresses: args.healthProgresses,
            smokingDetails: args.smokingDetails,
            user: args.user,
          ),
        );
      case ConsumptionPage.routeName:
        final args = settings.arguments as ConsumptionArguemnts;
        return MaterialPageRoute(
          builder: (context) => ConsumptionPage(
            user: args.user,
            smokingDetails: args.smokingDetails,
          ),
        );
      case FinancePage.routeName:
        final args = settings.arguments as FinanceArguments;
        return MaterialPageRoute(
          builder: (context) => FinancePage(
            finance: args.finance,
            user: args.user,
            moneySavedOnRelapse: args.moneySavedOnRelapse,
          ),
        );
      case AchievementPage.routeName:
        return MaterialPageRoute(builder: (context) => const AchievementPage());
      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
