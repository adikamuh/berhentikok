import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/page/home/cubit/tips_cubit.dart';
import 'package:berhentikok/page/home/widget/tips_dialog.dart';
import 'package:berhentikok/widget/card_widget/long_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TipsWidget extends StatefulWidget {
  const TipsWidget({Key? key}) : super(key: key);

  @override
  State<TipsWidget> createState() => _TipsWidgetState();
}

class _TipsWidgetState extends State<TipsWidget> {
  late int _indexTips;

  @override
  void initState() {
    super.initState();
    _indexTips = context.read<TipsCubit>().state.id;
  }

  @override
  Widget build(BuildContext context) {
    return LongCardWidget(
      text: "Baca Tips",
      backgroundColor: ColorConst.lightGreen,
      textColor: ColorConst.darkGreen,
      isSuffixIconOn: true,
      onTap: () async {
        await showDialog<int>(
          context: context,
          builder: (context) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              children: [
                TipsDialog(
                  tips: context.read<TipsCubit>().tipsRepository.load(),
                  indexTips: _indexTips,
                  onPrev: (int id) {
                    setState(() {
                      _indexTips = id;
                    });
                  },
                  onNext: (int id) {
                    setState(() {
                      _indexTips = id;
                    });
                  },
                )
              ],
            );
          },
        ).then((value) async {
          await context.read<TipsCubit>().putLastState(_indexTips);
        });
      },
    );
  }
}
