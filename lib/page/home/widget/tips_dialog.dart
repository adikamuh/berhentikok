import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/model/tips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TipsDialog extends StatefulWidget {
  const TipsDialog({Key? key}) : super(key: key);

  @override
  State<TipsDialog> createState() => _TipsDialogState();
}

class _TipsDialogState extends State<TipsDialog> {
  final tips = <Tips>[
    const Tips(
      'Simpan atau buang semua barang-barang yang memiliki kandungan nikotin di ruanganmu',
    ),
    const Tips(
      'middle',
    ),
    const Tips(
      'end',
    ),
  ];

  int _indexTips = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 25.h,
          ),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Text(
                tips[_indexTips].description,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (_indexTips > 0) {
                        setState(() {
                          _indexTips = _indexTips - 1;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: _indexTips == 0
                            ? ColorConst.primaryColor4
                            : ColorConst.primaryColor3,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.keyboard_arrow_left_rounded),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    radius: 0,
                    onTap: () {
                      if (_indexTips < (tips.length - 1)) {
                        setState(() {
                          _indexTips = _indexTips + 1;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: _indexTips == (tips.length - 1)
                            ? ColorConst.primaryColor4
                            : ColorConst.primaryColor3,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.keyboard_arrow_right_rounded),
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
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
