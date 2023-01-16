import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/base/int_extension.dart';
import 'package:berhentikok/base/page_arguments.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/base/string_extension.dart';
import 'package:berhentikok/model/health_progress.dart';
import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/achievement/bloc/achievement_bloc.dart';
import 'package:berhentikok/page/consumption/bloc/consumption_bloc.dart';
import 'package:berhentikok/page/consumption/consumption_page.dart';
import 'package:berhentikok/page/consumption/widget/smoking_free_duration_card.dart';
import 'package:berhentikok/page/finance/bloc/finance_bloc.dart';
import 'package:berhentikok/page/finance/finance_page.dart';
import 'package:berhentikok/page/health/bloc/health_bloc.dart';
import 'package:berhentikok/page/health/health_page.dart';
import 'package:berhentikok/page/health/widget/health_card_widget.dart';
import 'package:berhentikok/page/home/bloc/home_page_bloc.dart';
import 'package:berhentikok/page/home/cubit/smoking_strategy_cubit.dart';
import 'package:berhentikok/page/home/widget/custom_box_widget.dart';
import 'package:berhentikok/page/home/widget/smoking_cessation_strategy_dialog.dart';
import 'package:berhentikok/page/home/widget/smoking_quota_widget.dart';
import 'package:berhentikok/page/home/widget/tips_widget.dart';
import 'package:berhentikok/widget/card_widget/box_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:round_spot/round_spot.dart';

class HomePageDetail extends StatefulWidget {
  const HomePageDetail({Key? key}) : super(key: key);

  @override
  State<HomePageDetail> createState() => _HomePageDetailState();
}

class _HomePageDetailState extends State<HomePageDetail> {
  late final HomePageBloc homePageBloc;
  late final HealthBloc healthBloc;
  late final ConsumptionBloc consumptionBloc;
  late final FinanceBloc financeBloc;
  late final AchievementBloc achievementBloc;
  // late final TipsCubit tipsCubit;

  @override
  void initState() {
    super.initState();
    homePageBloc = context.read<HomePageBloc>()..add(FetchUser());
    healthBloc = context.read<HealthBloc>()..add(LoadHealth());
    consumptionBloc = context.read<ConsumptionBloc>()..add(LoadConsumption());
    financeBloc = context.read<FinanceBloc>()..add(LoadFinance());
    achievementBloc = context.read<AchievementBloc>()..add(LoadAchievement());
  }

  @override
  Widget build(BuildContext context) {
    return Detector(
      areaID: 'home',
      child: SingleChildScrollView(
        child: BlocConsumer<HomePageBloc, HomePageState>(
          bloc: homePageBloc,
          listener: (context, state) {
            if (state is UserLoaded) {
              if (state.user.isFistTime) {
                _showSmokingCessationStrategy(
                  context: context,
                  isFirst: true,
                );
              }
            }
          },
          builder: (context, state) {
            if (state is UserLoaded) {
              final User user = state.user;
              return Column(
                children: [
                  _buildHeader(context, user),
                  SizedBox(height: 18.h),
                  Padding(
                    padding: SizeConst.pagePadding,
                    child: Column(
                      children: [
                        _buildSokingQuota(),
                        SizedBox(height: 8.w),
                        _buildConsumptionSummary(context, user),
                        SizedBox(height: 8.w),
                        Row(
                          children: [
                            const Expanded(child: TipsWidget()),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: CustomBoxWidget(
                                text: "Strategimu untuk Berhenti Merokok",
                                icon: Icons.insights_rounded,
                                backgroundColor: ColorConst.lightGreen,
                                iconColor: ColorConst.darkGreen,
                                textColor: Colors.grey.shade800,
                                onTap: () {
                                  _showSmokingCessationStrategy(
                                    context: context,
                                    isFirst: false,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),
                        _buildOverallSummary(user),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is HomePageFailed) {
              state.errorMessage.showToast();
              return Text(
                'Muat ulang',
                style: FontConst.header3(color: ColorConst.darkRed),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, User user) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
        color: ColorConst.darkGreen,
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80.w,
            left: -120.w,
            child: Container(
              width: 250.w,
              height: 250.w,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 55, 126, 83),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: SizeConst.pagePadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${user.name.getFirstWord()}",
                        style: FontConst.header1(color: Colors.white),
                      ),
                      Text(
                        "Saya berhenti merokok ${user.motivation.toLowerCase()}",
                        style: FontConst.subtitle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30.w),
                // BlocBuilder<AchievementBloc, Resource<AchievementState>>(
                //   bloc: achievementBloc,
                //   builder: (context, state) {
                //     if (state is Success) {
                //       return InkWell(
                //         onTap: () async {
                //           await Navigator.of(context).pushNamed(
                //             AchievementPage.routeName,
                //           );
                //         },
                //         child: Stack(
                //           children: [
                //             const Icon(
                //               Icons.stars_rounded,
                //               color: Colors.white,
                //             ),
                //             if (!state.inferredData!.isAllRead)
                //               Positioned(
                //                 top: 0,
                //                 right: 0,
                //                 child: Container(
                //                   width: 10.w,
                //                   height: 10.w,
                //                   decoration: BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     color: ColorConst.secondaryColor2,
                //                     boxShadow: [
                //                       BoxShadow(
                //                         color: Colors.black.withOpacity(0.5),
                //                         offset: const Offset(-1, 2),
                //                         blurRadius: 3,
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               )
                //           ],
                //         ),
                //       );
                //     }
                //     return const SizedBox();
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSokingQuota() {
    return BlocBuilder<SmokingStrategyCubit, Resource<SmokingStrategyState>>(
      builder: (context, state) {
        if ((state is! Success)) return const SizedBox();
        return SmokingQuotaWidget(
          smokingQuota: state.inferredData!.smokingQuota,
        );
      },
    );
  }

  Widget _buildConsumptionSummary(BuildContext context, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SmokingFreeDurationCard(user: user),
            ),
          ],
        ),
      ],
    );
  }

  // Widget _buildTips() {
  //   return
  // }

  Widget _buildOverallSummary(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overall Progress',
          style: FontConst.header2(color: ColorConst.blackColor2),
        ),
        SizedBox(height: 12.h),
        BlocBuilder<HealthBloc, Resource<HealthState>>(
          bloc: healthBloc,
          builder: (context, state) {
            if (state is Success) {
              final Duration freeSmokingDuration =
                  state.inferredData!.smokingDetails.freeSmokingDuration(user);
              final healthProgress =
                  state.inferredData!.healthProgresses.firstWhereOnProgress(
                user: user,
                smokingDetails: state.inferredData!.smokingDetails,
              );
              if (healthProgress != null) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      HealthPage.routeName,
                      arguments: HealthArguments(
                        healthProgresses: state.inferredData!.healthProgresses,
                        smokingDetails: state.inferredData!.smokingDetails,
                        user: state.inferredData!.user,
                      ),
                    );
                  },
                  child: HealthCardWidget(
                    healthProgress: healthProgress,
                    smokingDetails: state.inferredData!.smokingDetails,
                    user: user,
                    freeSmokingDuration: freeSmokingDuration,
                    backgroundColor: ColorConst.lightGreen,
                    textColor: ColorConst.darkGreen,
                    linearValueColor: ColorConst.darkGreen,
                    linearBackgroundColor: ColorConst.lightGlowingGreen,
                  ),
                );
              }
            }
            return const SizedBox();
          },
        ),
        SizedBox(height: 8.w),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<FinanceBloc, Resource<FinanceState>>(
              bloc: financeBloc,
              builder: (context, state) {
                if (state is Success) {
                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          FinancePage.routeName,
                          arguments: FinanceArguments(
                            finance: state.inferredData!.finance,
                            user: state.inferredData!.user,
                            moneySavedOnRelapse:
                                state.inferredData!.moneySavedOnRelapse,
                          ),
                        );
                      },
                      child: BoxCardWidget(
                        backgroundColor: ColorConst.lightGreen,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icons/ic-savings.png',
                              width: 40.w,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              state.inferredData!.moneySavedOnRelapse
                                  .toCurrencyFormatter(),
                              style: FontConst.subtitle(
                                color: ColorConst.darkGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            SizedBox(width: 8.w),
            BlocBuilder<ConsumptionBloc, Resource<ConsumptionState>>(
              bloc: consumptionBloc,
              builder: (context, state) {
                if (state is Success) {
                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          ConsumptionPage.routeName,
                          arguments: ConsumptionArguemnts(
                            user: state.inferredData!.user,
                            smokingDetails: state.inferredData!.smokingDetails,
                          ),
                        );
                      },
                      child: BoxCardWidget(
                        backgroundColor: ColorConst.lightGreen,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icons/ic-free-smoking.png',
                              width: 40.w,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '${state.inferredData?.smokingDetails.totalFreeCigaretteOnRelapse(user)} batang rokok',
                              style: FontConst.subtitle(
                                color: ColorConst.darkGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ],
    );
  }

  // Widget _buildOthers(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Lainnya",
  //         style: FontConst.header2(color: ColorConst.blackColor2),
  //       ),
  //       SizedBox(height: 12.h),
  //       const TipsWidget(),
  //       SizedBox(height: 8.h),
  //       LongCardWidget(
  //         text: "Cara-cara untuk berhenti merokok",
  //         backgroundColor: ColorConst.lightGreen,
  //         textColor: ColorConst.darkGreen,
  //         isSuffixIconOn: true,
  //         onTap: () {
  //           _showSmokingCessationMethods(context: context, isFirst: false);
  //         },
  //       ),
  //     ],
  //   );
  // }

  // void _showTips() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Swiper(
  //         indicatorLayout: PageIndicatorLayout.WARM,
  //         itemBuilder: (BuildContext context, int index) {
  //           return Column(
  //             children: [
  //               // Text(data)
  //             ],
  //           );
  //         },
  //         itemCount: 10,
  //         itemWidth: 300.w,
  //         itemHeight: 500.h,
  //         layout: SwiperLayout.STACK,
  //         loop: false,
  //       );
  //     },
  //   );
  // }

  void _showSmokingCessationStrategy({
    required BuildContext context,
    bool isFirst = true,
  }) {
    showDialog(
      barrierDismissible: isFirst ? false : true,
      context: context,
      builder: (context) => Detector(
        areaID: 'smoking-methods-page',
        child: SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 25.h,
          ),
          children: const [SmokingCessationStrategyDialog()],
        ),
      ),
    );
  }
}
