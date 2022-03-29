abstract class RandomNumberEvent {}

class GenerateRandomNumber extends RandomNumberEvent {
  final int max;
  final int min;

  GenerateRandomNumber({required this.max, required this.min});
}


class ResetRandomNumber extends RandomNumberEvent {}

class CounterIncrementPressed extends RandomNumberEvent {}

class CounterDecrementPressed extends RandomNumberEvent {}