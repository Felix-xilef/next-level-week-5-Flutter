import 'package:flutter/cupertino.dart';

class ChallengeController {
  final currentPageNotifier = ValueNotifier<int>(1);
  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;

  final answeredNotifier = ValueNotifier<bool>(false);
  bool get answered => answeredNotifier.value;
  set answered(bool value) => answeredNotifier.value = value;
}
