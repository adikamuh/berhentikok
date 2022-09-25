import 'dart:collection';

import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
  SmokingDetailBloc({required this.smokingDetailRepository})
      : super(Resource.idle()) {
    on<AddSmokingDetail>((event, emit) async {
      try {
        await smokingDetailRepository.add(event.smokingDetail);
      } catch (e) {
        emit(Resource.error(e.toString()));
      } finally {
        add(LoadSmokingDetails());
      }
    });

    on<LoadSmokingDetails>((event, emit) async {
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
}
