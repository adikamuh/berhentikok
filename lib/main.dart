// import 'package:firebase_storage/firebase_storage.dart';

import 'package:berhentikok/page/home/cubit/smoking_strategy_cubit.dart';

import 'firebase_options.dart';

import 'package:berhentikok/generate_routes.dart';
import 'package:berhentikok/model/achievement.dart';
import 'package:berhentikok/model/boxes_name.dart';
import 'package:berhentikok/model/duration_adapter.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/target_item.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/achievement/bloc/achievement_bloc.dart';
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
import 'package:berhentikok/repositories/tips_repository.dart';
import 'package:berhentikok/repositories/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:round_spot/round_spot.dart' as rs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initHive();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initializeDateFormatting('id_ID').then((_) {
    // final storageRef = FirebaseStorage.instance.ref();
    // final Box<User> userBox = Hive.box<User>(usersBoxName);

    return runApp(
      rs.initialize(
        loggingLevel: rs.LogLevel.warning,
        config: rs.Config(
          outputType: rs.OutputType.localRender,
        ),
        localRenderCallback: (data, info) async {
          // final User? user = userBox.getAt(0);

          // storageRef
          //     .child(
          //         'berhentikok/heatmap/${user?.name ?? 'unknown_user'}/_${info.page}_${info.area}.png')
          //     .putData(data);
        },
        dataCallback: (data) {
          debugPrint(data.toString());
        },
        child: MultiRepositoryProvider(
          providers: _buildRepositories(),
          child: const MyApp(),
        ),
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
    await Hive.openBox<Achievement>(achievementsReadBoxName);
    await Hive.openBox<int>(tipsBoxName);
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
    Hive.box<Achievement>(achievementsReadBoxName),
  );
  final TipsRepository tipsRepository =
      TipsRepository(Hive.box<int>(tipsBoxName));
  return [
    RepositoryProvider<UserRepository>.value(value: userRepository),
    RepositoryProvider<SmokingDetailRepository>.value(
        value: smokingDetailRepository),
    RepositoryProvider<TargetItemRepository>.value(value: targetItemRepository),
    RepositoryProvider<HealthProgressRepository>.value(
        value: healthProgressRepository),
    RepositoryProvider<AchievementRepository>.value(
        value: achievementRepository),
    RepositoryProvider<TipsRepository>.value(value: tipsRepository),
  ];
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final HealthBloc healthBloc;
  late final FinanceBloc financeBloc;
  late final ConsumptionBloc consumptionBloc;
  late final SmokingStrategyCubit smokingStrategyCubit;
  late final ConsumptionChartCubit consumptionChartCubit;
  late final SmokingDetailBloc smokingDetailBloc;

  @override
  void initState() {
    super.initState();
    healthBloc = HealthBloc(
      healthProgressRepository:
          RepositoryProvider.of<HealthProgressRepository>(context),
      userRepository: RepositoryProvider.of<UserRepository>(context),
      smokingDetailRepository:
          RepositoryProvider.of<SmokingDetailRepository>(context),
    );
    financeBloc = FinanceBloc(
      userRepository: RepositoryProvider.of<UserRepository>(context),
      targetItemRepository:
          RepositoryProvider.of<TargetItemRepository>(context),
      smokingDetailRepository:
          RepositoryProvider.of<SmokingDetailRepository>(context),
    );
    consumptionBloc = ConsumptionBloc(
      userRepository: RepositoryProvider.of<UserRepository>(context),
      smokingDetailRepository:
          RepositoryProvider.of<SmokingDetailRepository>(context),
    );
    smokingStrategyCubit = SmokingStrategyCubit(
      userRepository: RepositoryProvider.of<UserRepository>(context),
      smokingDetailRepository:
          RepositoryProvider.of<SmokingDetailRepository>(context),
    );
    consumptionChartCubit = ConsumptionChartCubit(
      userRepository: RepositoryProvider.of<UserRepository>(context),
      smokingDetailRepository:
          RepositoryProvider.of<SmokingDetailRepository>(context),
    );
    smokingDetailBloc = SmokingDetailBloc(
      smokingDetailRepository:
          RepositoryProvider.of<SmokingDetailRepository>(context),
      healthBloc: healthBloc,
      financeBloc: financeBloc,
      consumptionBloc: consumptionBloc,
      smokingStrategyCubit: smokingStrategyCubit,
      consumptionChartCubit: consumptionChartCubit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 823),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: _buildBlocProviders(context),
          child: MaterialApp(
            navigatorObservers: [rs.Observer()],
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
            theme: ThemeData(fontFamily: 'Poppins'),
            onGenerateRoute: AppRoute.generateRoute,
            initialRoute: _checkIsRegistered(context)
                ? HomePage.routeName
                : OnBoardingPage.routeName,
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
          smokingStrategyCubit: smokingStrategyCubit,
        ),
      ),
      BlocProvider<HomePageBloc>(
        create: (context) => HomePageBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
      ),
      BlocProvider<HealthBloc>.value(value: healthBloc),
      BlocProvider<FinanceBloc>.value(value: financeBloc),
      BlocProvider<AddItemBloc>(
        create: (context) => AddItemBloc(
          targetItemRepository:
              RepositoryProvider.of<TargetItemRepository>(context),
        ),
      ),
      BlocProvider<SmokingDetailBloc>.value(value: smokingDetailBloc),
      BlocProvider<ConsumptionBloc>.value(value: consumptionBloc),
      BlocProvider<ConsumptionChartCubit>.value(value: consumptionChartCubit),
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
          financeBloc: financeBloc,
        ),
      ),
      BlocProvider<SmokingStrategyCubit>.value(value: smokingStrategyCubit),
      // BlocProvider<TipsCubit>(
      //   create: (context) =>
      //       TipsCubit(RepositoryProvider.of<TipsRepository>(context)),
      // )
    ];
  }
}
