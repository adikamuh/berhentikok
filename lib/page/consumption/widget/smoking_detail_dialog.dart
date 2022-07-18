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
        Text(_dateFormat.format(smokingDetail.date)),
        SizedBox(height: 8.h),
        Row(
          children: [
            const Text('Jumlah Rokok: '),
            Text("${smokingDetail.total.toString()} Rokok"),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            const Text('Alasan: '),
            Text(smokingDetail.excuse),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
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
