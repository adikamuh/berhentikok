import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/model/tips.dart';
import 'package:berhentikok/page/home/widget/custom_box_widget.dart';
import 'package:berhentikok/repositories/tips_repository.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TipsWidget extends StatefulWidget {
  const TipsWidget({super.key});

  @override
  State<TipsWidget> createState() => _TipsWidgetState();
}

class _TipsWidgetState extends State<TipsWidget> {
  // late int _indexTips;
  late List<Tips> tips;

  @override
  void initState() {
    super.initState();
    tips = RepositoryProvider.of<TipsRepository>(context).load();
    // _indexTips = context.read<TipsCubit>().state.id;
  }

  @override
  Widget build(BuildContext context) {
    return CustomBoxWidget(
      text: "Tips berhenti merokok",
      icon: Icons.info_outline,
      backgroundColor: Colors.transparent,
      outlineBorderColor: ColorConst.lightGreen,
      iconColor: Colors.blue.shade900,
      textColor: Colors.grey.shade800,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorConst.lightRed,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        color: ColorConst.darkRed,
                      ),
                    ),
                  ),
                ),
                Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(32.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            offset: const Offset(-1, 2),
                            blurRadius: 3,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 170.w,
                            height: 200.h,
                            child: Image.asset(
                              'assets/tips/illustration-tips-$index.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(tips[index].description),
                        ],
                      ),
                    );
                  },
                  itemCount: tips.length,
                  itemWidth: 300.w,
                  itemHeight: 380.h,
                  layout: SwiperLayout.TINDER,
                  loop: true,
                  outer: true,
                ),
              ],
            );
          },
        );
      },
    );
    // return LongCardWidget(
    //   text: "Tips Berhenti Merokok",
    //   backgroundColor: ColorConst.lightGreen,
    //   textColor: ColorConst.darkGreen,
    //   isSuffixIconOn: true,
    //   onTap: () async {
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return Swiper(
    //           indicatorLayout: PageIndicatorLayout.WARM,
    //           itemBuilder: (BuildContext context, int index) {
    //             return Container(
    //               padding: EdgeInsets.all(32.w),
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(16.r),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.black.withOpacity(0.5),
    //                     offset: const Offset(-1, 2),
    //                     blurRadius: 3,
    //                   )
    //                 ],
    //               ),
    //               child: Column(
    //                 children: [
    //                   SizedBox(
    //                     width: 170.w,
    //                     height: 200.h,
    //                     child: Image.asset(
    //                       'assets/tips/illustration-tips-$index.png',
    //                       fit: BoxFit.contain,
    //                     ),
    //                   ),
    //                   SizedBox(height: 12.h),
    //                   Text(tips[index].description),
    //                 ],
    //               ),
    //             );
    //           },
    //           itemCount: tips.length,
    //           itemWidth: 300.w,
    //           itemHeight: 380.h,
    //           layout: SwiperLayout.TINDER,
    //           loop: true,
    //         );
    //       },
    //     );
    //     // await showDialog<int>(
    //     //   context: context,
    //     //   builder: (context) {
    //     //     return Detector(
    //     //       areaID: 'tips-dialog',
    //     //       child: SimpleDialog(
    //     //         shape: RoundedRectangleBorder(
    //     //           borderRadius: BorderRadius.circular(12.r),
    //     //         ),
    //     //         children: [
    //     //           TipsDialog(
    //     //             tips: context.read<TipsCubit>().tipsRepository.load(),
    //     //             indexTips: _indexTips,
    //     //             onPrev: _onNextPrev,
    //     //             onNext: _onNextPrev,
    //     //           )
    //     //         ],
    //     //       ),
    //     //     );
    //     //   },
    //     // ).then((value) async {
    //     //   await context.read<TipsCubit>().putLastState(_indexTips);
    //     // });
    //   },
    // );
  }

  // void _onNextPrev(int id) {
  //   setState(() {
  //     _indexTips = id;
  //   });
  // }
}
