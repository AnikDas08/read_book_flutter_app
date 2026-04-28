import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'power_stone_notifier.g.dart';

class PowerStoneState {
  final int availableStones;
  final int adsWatchedToday;
  final int maxAdsPerDay;

  const PowerStoneState({
    this.availableStones = 5,
    this.adsWatchedToday = 0,
    this.maxAdsPerDay = 3,
  });

  PowerStoneState copyWith({
    int? availableStones,
    int? adsWatchedToday,
    int? maxAdsPerDay,
  }) {
    return PowerStoneState(
      availableStones: availableStones ?? this.availableStones,
      adsWatchedToday: adsWatchedToday ?? this.adsWatchedToday,
      maxAdsPerDay: maxAdsPerDay ?? this.maxAdsPerDay,
    );
  }
}

@Riverpod(keepAlive: true)
class PowerStoneNotifier extends _$PowerStoneNotifier {
  @override
  PowerStoneState build() {
    return const PowerStoneState();
  }

  void addPowerStones(int amount) {
    state = state.copyWith(availableStones: state.availableStones + amount);
  }

  void incrementAdsWatched() {
    if (state.adsWatchedToday < state.maxAdsPerDay) {
      state = state.copyWith(adsWatchedToday: state.adsWatchedToday + 1);
      addPowerStones(2);
    }
  }
}
