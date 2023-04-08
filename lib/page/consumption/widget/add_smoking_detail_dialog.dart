import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/date_format_const.dart';
import 'package:berhentikok/base/string_extension.dart';
import 'package:berhentikok/model/resource.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/consumption/bloc/smoking_detail_bloc.dart';
import 'package:berhentikok/widget/field_widget/date_time_field_widget.dart';
import 'package:berhentikok/widget/field_widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSmokingDetailDialog extends StatefulWidget {
  final User user;
  const AddSmokingDetailDialog({Key? key, required this.user})
      : super(key: key);

  @override
  State<AddSmokingDetailDialog> createState() => _AddSmokingDetailDialogState();
}

class _AddSmokingDetailDialogState extends State<AddSmokingDetailDialog> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _date;
  String? _excuse;
  int? _total;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SmokingDetailBloc, Resource<SmokingDetailState>>(
      listener: (context, state) {
        if (state is Success) {
          Navigator.of(context).pop();
        } else if (state is Error) {
          state.inferredErrorMessage?.showToast();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFieldWidget(
              label: 'Jumlah rokok yang kamu konsumsi',
              textInputAction: TextInputAction.next,
              isNumber: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _total = int.parse(value);
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Jumlah rokok harus diisi.';
                } else if (int.parse(value) <= 0) {
                  return 'Jumlah rokok harus lebih dari 0.';
                }
                return null;
              },
            ),
            DateTimeFieldWidget(
              label: 'Kapan kamu terakhir merokok',
              firstDate: widget.user.startDateStopSmoking,
              lastDate: DateTime.now(),
              suffix: const Icon(Icons.calendar_month),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _date = value;
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tanggal kamu merokok harus diisi.';
                } else if (DateTime.now()
                        .compareTo(AppDateFormat.dateFormat.parse(value)) <
                    0) {
                  return 'Nilai tanggal dan waktu maksimal adalah tanggal dan jam sekarang';
                }
                return null;
              },
            ),
            TextFieldWidget(
              label: 'Kenapa kamu merokok kembali',
              textInputAction: TextInputAction.done,
              maxLine: 3,
              onChanged: (value) {
                setState(() {
                  _excuse = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kenapa kamu merokok harus diisi.';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyleConst.danger(),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Batal'),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  style: ButtonStyleConst.primary(),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_date != null && _excuse != null && _total != null) {
                        final SmokingDetail smokingDetail = SmokingDetail(
                          date: _date!,
                          excuse: _excuse!,
                          total: _total!,
                        );
                        context
                            .read<SmokingDetailBloc>()
                            .add(AddSmokingDetail(smokingDetail));
                      } else {
                        if (_date == null) {
                          "Kenapa kamu harus merokok harus diisi".showToast();
                        }
                        if (_total == null) {
                          "Jumlah rokok harus diisi".showToast();
                        }
                        if (_excuse == null) {
                          "Kenapa kamu merokok harus diisi".showToast();
                        }
                      }
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
