import 'package:berhentikok/base/color_const.dart';
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
    double _intervalX = chartType == ChartType.consumption ? 10 : 10000;

    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: false,
          horizontalInterval: 1,
          verticalInterval: 1,
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            axisNameWidget: const Text(
              "Hari",
              textAlign: TextAlign.center,
            ),
            axisNameSize: 25.w,
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 5,
              // getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            axisNameWidget: const Text(
              'Jumlah',
              textAlign: TextAlign.end,
            ),
            axisNameSize: 20.w,
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              interval: _intervalX,
              // getTitlesWidget: leftTitleWidgets,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(color: ColorConst.blackColor2),
            left: BorderSide(color: ColorConst.blackColor2),
          ),
        ),
        minX: 1,
        maxX: data
            .reduce((current, next) => current.x > next.x ? current : next)
            .x,
        minY: 0,
        maxY: data
            .reduce((current, next) => current.y > next.y ? current : next)
            .y,
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
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10rb';
        break;
      case 3:
        text = '30rb';
        break;
      case 5:
        text = '50rb';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('1', style: style);
        break;
      case 2:
        text = const Text('2', style: style);
        break;
      case 3:
        text = const Text('3', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }
}
