import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ads_helper.dart';

class BannerAdsView extends StatefulWidget {
  @override
  _BannerAdsViewState createState() => _BannerAdsViewState();
}

class _BannerAdsViewState extends State<BannerAdsView> {
  BannerAd? _ad;

  bool _isAdLoaded = false;

  @override
  void initState() {
    _ad = BannerAd(
      size: AdSize.banner,
      adUnitId: AdsHelper.bannerAdUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    ///Load Ads Here
    _ad!.load();
    super.initState();
  }

  @override
  void dispose() {
    _ad!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdLoaded == true) {
      return Container(
        child: AdWidget(ad: _ad!),
        width: _ad!.size.width.toDouble(),
        height: 72.0,
        alignment: Alignment.center,
      );
    } else {
      return Container();
    }
  }
}
