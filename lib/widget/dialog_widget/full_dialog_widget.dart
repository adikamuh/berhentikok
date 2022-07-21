import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullDialogWidget extends StatelessWidget {
  final String appBarTitle;
  final Widget child;
  final bool isShowLeadingIcon;
  const FullDialogWidget({
    Key? key,
    required this.child,
    required this.appBarTitle,
    this.isShowLeadingIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12.r),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            automaticallyImplyLeading: isShowLeadingIcon,
            elevation: 0,
            leading: isShowLeadingIcon
                ? BackButton(color: Colors.green.shade800)
                : null,
            title: Text(
              appBarTitle,
              style: TextStyle(
                color: Colors.green.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: child,
        ),
      ),
    );
  }
}
