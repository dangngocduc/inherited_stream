import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'inherited_stream.dart';
///
class InheritedCubit<State, C extends Cubit<State>>
    extends InheritedStream<Cubit<State>> {
  ///
  InheritedCubit({Key key, C cubit, Widget child})
      : super(key : key, stream: cubit, child: child);

  ///
  static State of<State, C extends Cubit<State> >(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType
    <InheritedCubit<State, C>>().stream.state;
  }
}