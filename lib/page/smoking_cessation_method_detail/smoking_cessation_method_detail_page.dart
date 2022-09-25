import 'package:berhentikok/widget/dialog_widget/full_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmokingCessationMethodDetailPage extends StatelessWidget {
  const SmokingCessationMethodDetailPage({Key? key}) : super(key: key);

  final String contentDetail = """
    Metode ini menggunakan bantuan produk dengan kandungan nikotin yang rendah. Biasanya diletakkan di dalam mulut. Penggunaan NRT dapat meningkatkan keberhasilan berhenti merokok sebanyak 50% - 70%. Nikotin dalam jumlah sedikit ini dapat membantu memuaskan keinginan Anda sehingga mengurangi keinginan untuk merokok. Nicotine replacement therapy dapat membantu Anda mengatasi gejala kesulitan berhenti merokok dan ngidam yang kebanyakan orang alami. Anda dapat menggunakan NRT segera setelah berhenti mengonsumsi produk tembakau. Meski tampak begitu menjanjikan, NRT tidak dapat menjadi satu-satunya cara berhenti merokok. NRT hanya mengatasi ketergantungan Anda terhadap nikotin.

    American Cancer Society mengungkapkan bahwa semua orang yang merokok dan ketergantungan dengan nikotin perlu melakukan nicotine replacement therapy untuk membantunya berhenti. Berikut ini adalah tanda ketergantungan berat terhadap nikotin.
      Merokok lebih dari satu bungkus per hari.
      Mengisap rokok lima menit setelah bangun tidur.
      Merokok bahkan saat sedang sakit.
      Bangun di malam hari untuk merokok.
      Merokok untuk meredakan gejala sakau.
      Semakin banyak poin yang Anda alami, semakin berat pula ketergantungan Anda terhadap nikotin.

    Terdapat berbagai macam jenis NRT, di antaranya adalah:
      Nicotine patches
      Nicotine gum
      Nicotine mouth/nasal spray
      Nicotine inhaler
      Nicotine lozanges

    Untuk mendapatkan berbagai jenis NRT bisa kalian dapatkan di Apotek terdekat atau e-commerce pilihan Anda.
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
                child: Text(contentDetail),
              ),
            ),
          )
        ],
      ),
    );
  }
}
