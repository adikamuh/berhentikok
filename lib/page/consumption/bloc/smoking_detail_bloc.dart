import 'dart:collection';

import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/repositories/smoking_detail_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

part 'smoking_detail_event.dart';
part 'smoking_detail_state.dart';

class SmokingDetailBloc extends Bloc<SmokingDetailEvent, SmokingDetailState> {
  final SmokingDetailRepository smokingDetailRepository;
  SmokingDetailBloc({required this.smokingDetailRepository})
      : super(SmokingDetailInitial()) {
    on<AddSmokingDetail>((event, emit) {
      try {
        smokingDetailRepository.add(event.smokingDetail);
        emit(SmokingDetailSubmitted());
      } catch (e) {
        emit(SmokingDetailFailed(e.toString()));
      }
    });

    on<LoadSmokingDetails>((event, emit) {
      try {
        final List<SmokingDetail> smokingDetails =
            smokingDetailRepository.loadAll();
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

        emit(SmokingDetailsLoaded(smokingDetailsMap));
      } catch (e) {
        emit(SmokingDetailFailed(e.toString()));
      }
    });
  }
}
