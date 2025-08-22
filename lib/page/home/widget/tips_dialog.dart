import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/model/tips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TipsDialog extends StatefulWidget {
  final List<Tips> tips;
  final int indexTips;
  final Function(int id) onPrev;
  final Function(int id) onNext;
  const TipsDialog({
    super.key,
    required this.tips,
    required this.indexTips,
    required this.onPrev,
    required this.onNext,
  });

  static const String routeName = 'tips-dialog';

  @override
  State<TipsDialog> createState() => _TipsDialogState();
}

class _TipsDialogState extends State<TipsDialog> {
  late int _indexTips;

  @override
  void initState() {
    super.initState();
    _indexTips = widget.indexTips;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Text(
                widget.tips[_indexTips].description,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap:
                        _indexTips > 0
                            ? () {
                              setState(() {
                                _indexTips = _indexTips - 1;
                              });
                              widget.onPrev(_indexTips);
                            }
                            : null,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color:
                            _indexTips == 0
                                ? ColorConst.lightGreen.withValues(alpha: 0.5)
                                : ColorConst.lightGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                        color: ColorConst.darkGreen,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    radius: 0,
                    onTap:
                        _indexTips < (widget.tips.length - 1)
                            ? () {
                              setState(() {
                                _indexTips = _indexTips + 1;
                              });
                              widget.onNext(_indexTips);
                            }
                            : null,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color:
                            _indexTips == (widget.tips.length - 1)
                                ? ColorConst.lightGreen.withValues(alpha: 0.5)
                                : ColorConst.lightGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: ColorConst.darkGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 15.w,
          top: 0,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: const BoxDecoration(
                color: ColorConst.lightRed,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close_rounded, color: ColorConst.darkRed),
            ),
          ),
        ),
      ],
    );
  }
}
