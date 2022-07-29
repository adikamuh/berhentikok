import 'package:berhentikok/base/button_style_const.dart';
import 'package:berhentikok/base/string_extension.dart';
import 'package:berhentikok/model/user.dart';
import 'package:berhentikok/page/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:berhentikok/widget/field_widget/date_time_field_widget.dart';
import 'package:berhentikok/widget/field_widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _formKey = GlobalKey<FormState>();
  static final DateFormat _dateFormat =
      DateFormat("d MMMM yyyy, HH:mm", 'id_ID');

  String? _name;
  int? _tobaccoConsumption;
  int? _averagePrice;
  int? _cigarettesPerPack;
  DateTime? _startDateStopSmoking;
  String? _motivation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: BlocListener<OnBoardingCubit, OnBoardingState>(
                listener: (context, state) {
                  if (state is FormSubmitted) {
                    Navigator.of(context).pushReplacementNamed('home');
                  }
                },
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFieldWidget(
                        label: 'Nama',
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama harus diisi.';
                          }
                          return null;
                        },
                      ),
                      TextFieldWidget(
                        label: 'Konsumsi rokok per hari',
                        isNumber: true,
                        onChanged: (value) {
                          setState(() {
                            _tobaccoConsumption =
                                value.thousandFormatterToInt();
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Konsumsi rokok per hari harus diisi.';
                          } else if (value.thousandFormatterToInt() <= 0) {
                            return 'Jumlah konsumsi rokok harus lebih dari 0';
                          }
                          return null;
                        },
                      ),
                      TextFieldWidget(
                        label: 'Rata-rata harga rokok sebungkus',
                        prefix: const Text('Rp'),
                        textAlign: TextAlign.end,
                        isNumber: true,
                        onChanged: (value) {
                          setState(() {
                            _averagePrice = value.thousandFormatterToInt();
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Rata-rata harga rokok sebungkus harus diisi.';
                          } else if (value.thousandFormatterToInt() <= 0) {
                            return 'Harga harus lebih dari 0';
                          }
                          return null;
                        },
                      ),
                      TextFieldWidget(
                        label: 'Jumlah rokok sebungkus',
                        isNumber: true,
                        onChanged: (value) {
                          setState(() {
                            _cigarettesPerPack = value.thousandFormatterToInt();
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Jumlah rokok sebungkus harus diisi.';
                          } else if (value.thousandFormatterToInt() <= 0) {
                            return 'Jumlah rokok sebungkus harus lebih dari 0';
                          }
                          return null;
                        },
                      ),
                      DateTimeFieldWidget(
                        label: 'Mulai berhenti merokok',
                        onChanged: (value) {
                          if (value != null && value.isNotEmpty) {
                            setState(() {
                              _startDateStopSmoking = _dateFormat.parse(value);
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Harus diisi.';
                          }
                          return null;
                        },
                      ),
                      TextFieldWidget(
                        label: 'Motivasi untuk berhenti merokok',
                        hintText:
                            'Contoh: karena ingin uang saya dihabiskan dengan cukup baik',
                        maxLine: 3,
                        onChanged: (value) {
                          _motivation = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Motivasi harus diisi.';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyleConst.primary(),
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  if (_name != null &&
                                      _tobaccoConsumption != null &&
                                      _averagePrice != null &&
                                      _cigarettesPerPack != null &&
                                      _startDateStopSmoking != null &&
                                      _motivation != null) {
                                    final User _user = User(
                                      name: _name!,
                                      tobaccoConsumption: _tobaccoConsumption!,
                                      averagePrice: _averagePrice!,
                                      cigarettesPerPack: _cigarettesPerPack!,
                                      startDateStopSmoking:
                                          _startDateStopSmoking!,
                                      motivation: _motivation!,
                                    );
                                    context
                                        .read<OnBoardingCubit>()
                                        .submitForm(_user);
                                  } else {
                                    "Lengkapi Form".showToast();
                                  }
                                }
                              },
                              child: const Text('Simpan'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
