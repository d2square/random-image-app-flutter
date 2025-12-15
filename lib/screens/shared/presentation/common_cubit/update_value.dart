import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeValue<T> extends Cubit<T> {
  final Key? key;

  ChangeValue(
      super.initialState, {
        this.key,
      });

  void updateValue(T value) {
    emit(value);
  }
}
