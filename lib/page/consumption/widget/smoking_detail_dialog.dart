import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SmokingDetailDialog extends StatelessWidget {
  final SmokingDetail smokingDetail;
  const SmokingDetailDialog({
    Key? key,
    required this.smokingDetail,
  }) : super(key: key);

  static final DateFormat _dateFormat =
      DateFormat("d MMMM yyyy, hh:mm", 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _dateFormat.format(smokingDetail.date),
          style: FontConst.body(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah Rokok: ',
              style: FontConst.body(fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: Text("${smokingDetail.total.toString()} Rokok"),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alasan: ',
              style: FontConst.body(fontWeight: FontWeight.w600),
            ),
            Expanded(child: Text(smokingDetail.excuse)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyleConst.danger(),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        ),
      ],
    );
  }
}
