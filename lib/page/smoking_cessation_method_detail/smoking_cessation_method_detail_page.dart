import 'package:berhentikok/widget/dialog_widget/full_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingCessationMethodDetailPage extends StatelessWidget {
  final String contentDetail;
  final String title;
  final String? imagePath;
  const SmokingCessationMethodDetailPage({
    Key? key,
    required this.contentDetail,
    required this.title,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullDialogWidget(
      appBarTitle: title,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    if (imagePath != null) Image.asset(imagePath!),
                    Html(data: contentDetail),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
