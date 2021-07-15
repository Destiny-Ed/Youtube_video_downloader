import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ads_helper.dart';

void loadInterstitialAd() {
  InterstitialAd.load(
    adUnitId: AdsHelper.intertitialAdUnitId,
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        // _interstitialAd = ad;
        // notifyListeners();

        ad.show();

        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            print(ad.responseInfo);
          },
        );
        //
        // _isInterstitialAdReady = true;
        // notifyListeners();
      },
      onAdFailedToLoad: (err) {
        print('Failed to load an interstitial ad: ${err.message}');
        // _isInterstitialAdReady = false;
        // notifyListeners();
      },
    ),
  );
}
