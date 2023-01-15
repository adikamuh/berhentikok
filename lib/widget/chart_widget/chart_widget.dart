import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/base/int_extension.dart';
import 'package:berhentikok/model/chart_type.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartWidget extends StatelessWidget {
  final List<FlSpot> data;
  final ChartType chartType;
  const ChartWidget({
    Key? key,
    required this.data,
    required this.chartType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: true,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: ColorConst.greyColor2,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: chartType == ChartType.consumption
              ? AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: bottomTitleWidgets,
                  ),
                )
              : AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: chartType == ChartType.finance
              ? AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: bottomTitleWidgets,
                  ),
                )
              : AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            axisNameWidget: chartType == ChartType.consumption
                ? Text(
                    'Jumlah',
                    textAlign: TextAlign.start,
                    style: FontConst.body(fontWeight: FontWeight.bold),
                  )
                : null,
            axisNameSize: chartType == ChartType.consumption ? 35.w : null,
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60.w,
              getTitlesWidget: leftTitleWidgets,
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: ColorConst.lightGreen.withOpacity(0.5),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map(
                (barSpot) {
                  return LineTooltipItem(
                    barSpot.y.toInt().toCompactThousandFormatter() + "\n",
                    FontConst.small(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: "Hari ke-${barSpot.x.toInt()}",
                        style: FontConst.small().copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  );
                },
              ).toList();
            },
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: chartType == ChartType.finance
                ? const BorderSide(color: ColorConst.greyColor2, width: 3)
                : BorderSide.none,
            top: chartType == ChartType.consumption
                ? const BorderSide(color: ColorConst.greyColor2, width: 3)
                : BorderSide.none,
            // left: BorderSide(color: ColorConst.blackColor2),
          ),
        ),
        minX: 1,
        maxX: data.isNotEmpty
            ? data
                .reduce((current, next) => current.x > next.x ? current : next)
                .x
            : 1,
        minY: chartType == ChartType.consumption
            ? data.isNotEmpty
                ? data
                    .reduce(
                      (current, next) => current.y < next.y ? current : next,
                    )
                    .y
                : 0
            : data.isNotEmpty
                ? data.first.y
                : 0,
        maxY: data.isNotEmpty
            ? data
                .reduce((current, next) => current.y > next.y ? current : next)
                .y
            : 0,
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: false,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            barWidth: 5,
            isStrokeCapRound: false,
            dotData: FlDotData(
              show: true,
            ),
            // belowBarData: BarAreaData(
            //   show: true,
            //   gradient: LinearGradient(
            //     colors: gradientColors
            //         .map((color) => color.withOpacity(0.3))
            //         .toList(),
            //     begin: Alignment.centerLeft,
            //     end: Alignment.centerRight,
            //   ),
            // ),
          ),
        ],
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(
      chartType == ChartType.consumption
          ? value.toInt().toCompactThousandFormatter()
          : value.toInt().toCompactCurrencyFormatter(),
      style: FontConst.small(
        fontWeight: FontWeight.w600,
        color: ColorConst.blackColor2,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return Padding(
      padding: EdgeInsets.only(
        top: chartType == ChartType.finance ? 12.h : 0,
        bottom: chartType == ChartType.consumption ? 12.h : 0,
      ),
      child: Text(
        "Hari\nke-${value.toInt().toString()}",
        style: FontConst.small(
          fontWeight: FontWeight.w600,
          color: ColorConst.darkGreen,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
