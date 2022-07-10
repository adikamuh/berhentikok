import 'package:berhentikok/page/home/home_page.dart';
import 'package:berhentikok/page/on_boarding/on_boarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('id_ID').then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    final textTheme = Theme.of(context).textTheme;

    return ScreenUtilInit(
      designSize: const Size(412, 823),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'BerhentiKok',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(textTheme),
          ),
          routes: <String, WidgetBuilder>{
            '/': (context) => const OnBoardingPage(),
            '/home': (context) => const HomePage(),
          },
          initialRoute: "/home",
        );
      },
    );
  }
}
