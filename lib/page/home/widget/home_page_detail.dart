import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/base/int_extension.dart';
import 'package:berhentikok/base/size_const.dart';
import 'package:berhentikok/base/string_extension.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/achievement/achievement_page.dart';
import 'package:berhentikok/page/achievement/bloc/achievement_bloc.dart';
import 'package:berhentikok/page/achievement/cubit/achievement_indicator_cubit.dart';
import 'package:berhentikok/page/consumption/bloc/consumption_bloc.dart';
import 'package:berhentikok/page/consumption/widget/smoking_free_duration_card.dart';
import 'package:berhentikok/page/finance/bloc/finance_bloc.dart';
import 'package:berhentikok/page/health/bloc/health_bloc.dart';
import 'package:berhentikok/page/health/widget/health_card_widget.dart';
import 'package:berhentikok/page/home/bloc/home_page_bloc.dart';
import 'package:berhentikok/page/home/widget/tips_dialog.dart';
import 'package:berhentikok/page/smoking_cessation_methods/smoking_cessation_methods_page.dart';
import 'package:berhentikok/widget/card_widget/box_card_widget.dart';
import 'package:berhentikok/widget/card_widget/long_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageDetail extends StatefulWidget {
  const HomePageDetail({Key? key}) : super(key: key);

  @override
  State<HomePageDetail> createState() => _HomePageDetailState();
}

class _HomePageDetailState extends State<HomePageDetail> {
  late HomePageBloc _homePageBloc;

  @override
  void initState() {
    _homePageBloc = context.read<HomePageBloc>()..add(FetchUser());
    context.read<HealthBloc>().add(LoadHealth());
    context.read<ConsumptionBloc>().add(LoadConsumption());
    context.read<FinanceBloc>().add(LoadFinance());
    context.read<AchievementBloc>().add(LoadAchievement());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<HomePageBloc, HomePageState>(
        bloc: _homePageBloc,
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
                      _buildConsumptionSummary(context, user),
                      SizedBox(height: 18.h),
                      _buildOverallSummary(user),
                      SizedBox(height: 18.h),
                      _buildOthers(context),
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
    );
  }

  Widget _buildHeader(BuildContext context, User user) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
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
                color: Color(0xff4B8A64),
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
                        "Ingat terus untuk tetap berhenti merokok ${user.motivation.toLowerCase()}",
                        style: FontConst.subtitle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30.w),
                BlocBuilder<AchievementBloc, AchievementState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () async {
                        context
                            .read<AchievementIndicatorClickedCubit>()
                            .click();
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => AchievementPage(
                                  achievements: state.achievements,
                                )),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.stars_rounded,
                            color: Colors.white,
                          ),
                          if (state.isNewAchieved &&
                              !context
                                  .read<AchievementIndicatorClickedCubit>()
                                  .state)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConst.secondaryColor2,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      offset: const Offset(-1, 2),
                                      blurRadius: 3,
                                    )
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsumptionSummary(BuildContext context, User user) {
    return BlocBuilder<ConsumptionBloc, ConsumptionState>(
      builder: (context, state) {
        if (state is ConsumptionLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SmokingFreeDurationCard(
                      user: state.user,
                      smokingDetails: state.smokingDetails,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildOverallSummary(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overall Progress',
          style: FontConst.header2(color: ColorConst.blackColor2),
        ),
        SizedBox(height: 12.h),
        BlocBuilder<HealthBloc, HealthState>(
          builder: (context, state) {
            if (state is HealthLoaded) {
              return HealthCardWidget(
                healthProgress: state.healthProgresses.first,
                smokingDetails: state.smokingDetails,
                user: user,
                backgroundColor: ColorConst.lightGreen,
                textColor: ColorConst.darkGreen,
                linearValueColor: ColorConst.darkGreen,
              );
            }
            return const SizedBox();
          },
        ),
        SizedBox(height: 8.w),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<FinanceBloc, FinanceState>(
              builder: (context, state) {
                if (state is FinanceLoaded) {
                  return Expanded(
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
                            state.moneySavedOnRelapse.toCurrencyFormatter(),
                            style: FontConst.subtitle(
                              color: ColorConst.darkGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            SizedBox(width: 8.w),
            BlocBuilder<ConsumptionBloc, ConsumptionState>(
              builder: (context, state) {
                if (state is ConsumptionLoaded) {
                  return Expanded(
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
                            '${state.smokingDetails.totalFreeCigaretteOnRelapse(user)} batang rokok',
                            style: FontConst.subtitle(
                              color: ColorConst.darkGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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

  Widget _buildOthers(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lainnya",
          style: FontConst.header2(color: ColorConst.blackColor2),
        ),
        SizedBox(height: 12.h),
        LongCardWidget(
          text: "Baca Tips",
          backgroundColor: ColorConst.lightGreen,
          textColor: ColorConst.darkGreen,
          isSuffixIconOn: true,
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  children: const [TipsDialog()],
                );
              },
            );
          },
        ),
        SizedBox(height: 8.h),
        LongCardWidget(
          text: "Cara-cara untuk berhenti merokok",
          backgroundColor: ColorConst.lightGreen,
          textColor: ColorConst.darkGreen,
          isSuffixIconOn: true,
          onTap: () {
            _showSmokingCessationMethods(context: context, isFirst: false);
          },
        ),
      ],
    );
  }

  void _showSmokingCessationMethods({
    required BuildContext context,
    bool isFirst = true,
  }) {
    showDialog(
      barrierDismissible: isFirst ? false : true,
      context: context,
      builder: (context) => SmokingCessationMethodsPage(isFirst: isFirst),
    );
  }
}
