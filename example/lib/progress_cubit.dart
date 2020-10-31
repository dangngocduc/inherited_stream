import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressCubit extends Cubit<double> {
  static const TAG = 'ProgressCubit';
  ///
  ProgressCubit(double state) : super(state);
  ///
  void add(double value) {
    emit(value);
  }

}