import 'dart:math';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:random_number_generator/bloc/random_number_event.dart';

class RandomNumberBloc extends HydratedBloc<RandomNumberEvent, int> {
  RandomNumberBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
    on<CounterDecrementPressed>((event, emit) => emit(state - 1));
    on<GenerateRandomNumber>((event, emit) =>
        emit(_fetchRandomNumber(maxNumber: event.max, minNumber: event.min)));
    on<ResetRandomNumber>((event, emit) => emit(0));
  }

  @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => {'value': state};

  int _fetchRandomNumber({required int maxNumber, required int minNumber}) {
    return minNumber + Random().nextInt(maxNumber - minNumber + 1);
  }
}