class AdService {
  bool get rewardedReady => false;
  bool get interstitialReady => false;

  void preload() {}
  void loadRewarded() {}
  void loadInterstitial() {}

  Future<bool> showRewarded() async => false;
  Future<bool> showInterstitial() async => false;

  void dispose() {}
}
