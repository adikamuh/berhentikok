import 'package:berhentikok/widget/dialog_widget/full_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingCessationMethodDetailPage extends StatelessWidget {
  const SmokingCessationMethodDetailPage({Key? key}) : super(key: key);

  final String contentDetail = """
    Metode ini menggunakan bantuan produk dengan kandungan nikotin yang rendah. Biasanya diletakkan di dalam mulut. Penggunaan NRT dapat meningkatkan keberhasilan berhenti merokok sebanyak 50% - 70%

    Terdapat berbagai macam jenis NRT, di antaranya adalah:
      Nicotine patches
      Nicotine gum
      Nicotine mouth/nasal spray
      Nicotine inhaler
      Nicotine lozanges
  """;

  @override
  Widget build(BuildContext context) {
    return FullDialogWidget(
      appBarTitle: 'Metode NRT',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(contentDetail +
                    contentDetail +
                    contentDetail +
                    contentDetail +
                    contentDetail),
              ),
            ),
          )
        ],
      ),
    );
  }
}
