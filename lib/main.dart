import 'package:berhentikok/model/achievement.dart';
import 'package:berhentikok/model/boxes_name.dart';
import 'package:berhentikok/model/duration_adapter.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/target_item.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/achievement/bloc/achievement_bloc.dart';
import 'package:berhentikok/page/achievement/cubit/achievement_indicator_cubit.dart';
import 'package:berhentikok/page/consumption/bloc/consumption_bloc.dart';
import 'package:berhentikok/page/consumption/bloc/smoking_detail_bloc.dart';
import 'package:berhentikok/page/consumption/cubit/consumption_chart_cubit.dart';
import 'package:berhentikok/page/finance/bloc/add_item_bloc.dart';
import 'package:berhentikok/page/finance/bloc/finance_bloc.dart';
import 'package:berhentikok/page/finance/cubit/finance_chart_cubit.dart';
import 'package:berhentikok/page/health/bloc/health_bloc.dart';
import 'package:berhentikok/page/home/bloc/home_page_bloc.dart';
import 'package:berhentikok/page/home/home_page.dart';
import 'package:berhentikok/page/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:berhentikok/page/on_boarding/on_boarding_page.dart';
import 'package:berhentikok/repositories/achievement_repository.dart';
import 'package:berhentikok/repositories/health_progress_repository.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:berhentikok/repositories/target_item_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  initializeDateFormatting('id_ID').then((_) {
    return runApp(
      MultiRepositoryProvider(
        providers: _buildRepositories(),
        child: const MyApp(),
      ),
    );
  });
}

Future<void> _initHive() async {
  try {
    await Hive.initFlutter();

    Hive.registerAdapter<User>(UserAdapter());
    Hive.registerAdapter<SmokingDetail>(SmokingDetailAdapter());
    Hive.registerAdapter<TargetItem>(TargetItemAdapter());
    Hive.registerAdapter<Achievement>(AchievementAdapter());
    Hive.registerAdapter<Duration>(DurationAdapter());

    await Hive.openBox<User>(usersBoxName);
    await Hive.openBox<SmokingDetail>(smokingDetailsBoxName);
    await Hive.openBox<TargetItem>(targetItemsBoxName);
    await Hive.openBox<Achievement>(achievementsAchievedBoxName);
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

List<RepositoryProvider> _buildRepositories() {
  final UserRepository userRepository =
      UserRepository(Hive.box<User>(usersBoxName));
  final SmokingDetailRepository smokingDetailRepository =
      SmokingDetailRepository(Hive.box<SmokingDetail>(smokingDetailsBoxName));
  final TargetItemRepository targetItemRepository =
      TargetItemRepository(Hive.box<TargetItem>(targetItemsBoxName));
  final HealthProgressRepository healthProgressRepository =
      HealthProgressRepository();
  final AchievementRepository achievementRepository = AchievementRepository(
    Hive.box<Achievement>(achievementsAchievedBoxName),
  );
  return [
    RepositoryProvider<UserRepository>.value(value: userRepository),
    RepositoryProvider<SmokingDetailRepository>.value(
        value: smokingDetailRepository),
    RepositoryProvider<TargetItemRepository>.value(value: targetItemRepository),
    RepositoryProvider<HealthProgressRepository>.value(
        value: healthProgressRepository),
    RepositoryProvider<AchievementRepository>.value(
        value: achievementRepository),
  ];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ScreenUtilInit(
      designSize: const Size(412, 823),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: _buildBlocProviders(context),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BerhentiKok',
            builder: (context, widget) {
              Widget child = MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child,
              );
            },
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(textTheme),
            ),
            routes: <String, WidgetBuilder>{
              'intro': (context) => const OnBoardingPage(),
              'home': (context) => const HomePage(),
            },
            initialRoute: _checkIsRegistered(context) ? "home" : "intro",
          ),
        );
      },
    );
  }

  bool _checkIsRegistered(BuildContext context) {
    return RepositoryProvider.of<UserRepository>(context).isRegistered();
  }

  List<BlocProvider> _buildBlocProviders(BuildContext context) {
    return [
      BlocProvider<OnBoardingCubit>(
        create: (context) => OnBoardingCubit(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
      ),
      BlocProvider<HomePageBloc>(
        create: (context) => HomePageBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
      ),
      BlocProvider<HealthBloc>(
        create: (context) => HealthBloc(
          healthProgressRepository:
              RepositoryProvider.of<HealthProgressRepository>(context),
          userRepository: RepositoryProvider.of<UserRepository>(context),
          smokingDetailRepository:
              RepositoryProvider.of<SmokingDetailRepository>(context),
        ),
      ),
      BlocProvider<FinanceBloc>(
        create: (context) => FinanceBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
          targetItemRepository:
              RepositoryProvider.of<TargetItemRepository>(context),
          smokingDetailRepository:
              RepositoryProvider.of<SmokingDetailRepository>(context),
        ),
      ),
      BlocProvider<AddItemBloc>(
        create: (context) => AddItemBloc(
          targetItemRepository:
              RepositoryProvider.of<TargetItemRepository>(context),
        ),
      ),
      BlocProvider<SmokingDetailBloc>(
        create: (context) => SmokingDetailBloc(
          smokingDetailRepository:
              RepositoryProvider.of<SmokingDetailRepository>(context),
        ),
      ),
      BlocProvider<ConsumptionBloc>(
        create: (context) => ConsumptionBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
          smokingDetailRepository:
              RepositoryProvider.of<SmokingDetailRepository>(context),
        ),
      ),
      BlocProvider<ConsumptionChartCubit>(
        create: (context) => ConsumptionChartCubit(
          userRepository: RepositoryProvider.of<UserRepository>(context),
          smokingDetailRepository:
              RepositoryProvider.of<SmokingDetailRepository>(context),
        ),
      ),
      BlocProvider<FinanceChartCubit>(
        create: (context) => FinanceChartCubit(
          userRepository: RepositoryProvider.of<UserRepository>(context),
          smokingDetailRepository:
              RepositoryProvider.of<SmokingDetailRepository>(context),
        ),
      ),
      BlocProvider<AchievementBloc>(
        create: (context) => AchievementBloc(
          achievementRepository:
              RepositoryProvider.of<AchievementRepository>(context),
          smokingDetailRepository:
              RepositoryProvider.of<SmokingDetailRepository>(context),
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
      ),
      BlocProvider<AchievementIndicatorClickedCubit>(
          create: (context) => AchievementIndicatorClickedCubit()),
    ];
  }
}
