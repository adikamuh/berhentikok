import 'dart:collection';

import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/page/consumption/bloc/consumption_bloc.dart';
import 'package:berhentikok/page/consumption/cubit/consumption_chart_cubit.dart';
import 'package:berhentikok/page/finance/bloc/finance_bloc.dart';
import 'package:berhentikok/page/health/bloc/health_bloc.dart';
import 'package:berhentikok/page/home/cubit/smoking_strategy_cubit.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

part 'smoking_detail_event.dart';

class SmokingDetailState extends Equatable {
  const SmokingDetailState(this.smokingDetailsMap);
  final Map<DateTime, List<SmokingDetail>> smokingDetailsMap;

  @override
  List<Object> get props => [];
}

class SmokingDetailBloc
    extends Bloc<SmokingDetailEvent, Resource<SmokingDetailState>> {
  final SmokingDetailRepository smokingDetailRepository;
  final HealthBloc healthBloc;
  final FinanceBloc financeBloc;
  final ConsumptionBloc consumptionBloc;
  final SmokingStrategyCubit smokingStrategyCubit;
  final ConsumptionChartCubit consumptionChartCubit;

  SmokingDetailBloc({
    required this.healthBloc,
    required this.financeBloc,
    required this.consumptionBloc,
    required this.smokingStrategyCubit,
    required this.consumptionChartCubit,
    required this.smokingDetailRepository,
  }) : super(Resource.idle()) {
    on<AddSmokingDetail>((event, emit) async {
      emit(Resource.loading());
      try {
        await smokingDetailRepository.add(event.smokingDetail);
      } catch (e) {
        emit(Resource.error(e.toString()));
      } finally {
        _reloadAll();
        add(LoadSmokingDetails());
      }
    });

    on<LoadSmokingDetails>((event, emit) async {
      emit(Resource.loading());
      try {
        final List<SmokingDetail> smokingDetails =
            await smokingDetailRepository.loadAll();
        LinkedHashMap<DateTime, List<SmokingDetail>> smokingDetailsMap =
            LinkedHashMap<DateTime, List<SmokingDetail>>(
              equals: isSameDay,
              hashCode: SmokingDetail.getHashCode,
            );
        smokingDetails.forEach(((smokingDetail) {
          final currentSmokingDetailMap = smokingDetailsMap[smokingDetail.date];
          if (currentSmokingDetailMap != null) {
            currentSmokingDetailMap.add(smokingDetail);
          }
          smokingDetailsMap.addAll({
            smokingDetail.date: currentSmokingDetailMap ?? [smokingDetail],
          });
        }));

        emit(Resource.success(SmokingDetailState(Map.from(smokingDetailsMap))));
      } catch (e) {
        emit(Resource.error(e.toString()));
      }
    });
  }

  void _reloadAll() {
    healthBloc.add(LoadHealth());
    financeBloc.add(LoadFinance());
    consumptionBloc.add(LoadConsumption());
    smokingStrategyCubit.init();
    consumptionChartCubit.load();
  }
}
