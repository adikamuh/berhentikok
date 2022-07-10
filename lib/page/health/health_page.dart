import 'package:berhentikok/page/health/widget/health_card_widget.dart';
import 'package:flutter/material.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kesehatan"),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: const [
                HealthCardWidget(
                  iconData: Icons.bloodtype_rounded,
                  caption: "Tekanan darah kembali nromal",
                  progressValue: 0.2,
                ),
                HealthCardWidget(
                  iconData: Icons.bloodtype_rounded,
                  caption: "Tekanan darah kembali nromal",
                  progressValue: 0.2,
                ),
                HealthCardWidget(
                  iconData: Icons.bloodtype_rounded,
                  caption: "Tekanan darah kembali nromal",
                  progressValue: 0.2,
                ),
                HealthCardWidget(
                  iconData: Icons.bloodtype_rounded,
                  caption: "Tekanan darah kembali nromal",
                  progressValue: 0.2,
                ),
                HealthCardWidget(
                  iconData: Icons.bloodtype_rounded,
                  caption: "Tekanan darah kembali nromal",
                  progressValue: 0.2,
                ),
                HealthCardWidget(
                  iconData: Icons.bloodtype_rounded,
                  caption: "Tekanan darah kembali nromal",
                  progressValue: 0.2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
