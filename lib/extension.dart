import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'inherited_cubit.dart';

///
extension InheritedCubitExt on BuildContext {
  ///
  State watch<State, C extends Cubit<State>>() {
    return InheritedCubit.of<State, C>(this);
  }
}