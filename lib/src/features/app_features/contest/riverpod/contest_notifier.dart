import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unkutdrama_kpnovel/config/constance/enums.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/contest/riverpod/constest_state.dart';

part 'contest_notifier.g.dart';

@Riverpod()
class ContestNotifier extends _$ContestNotifier {
  @override
  ContestState build(ContestType contestType) {
    return ContestState();
  }
}

@riverpod
class SelectedContest extends _$SelectedContest {
  @override
  ContestType build() {
    return ContestType.Writers;
  }

  void setContest(ContestType value) {
    state = value;
  }
}

