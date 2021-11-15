
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobBanner extends StatefulWidget {
  AdmobBanner({Key? key}) : super(key: key);

  @override
  State<AdmobBanner> createState() => _AdmobBannerState();
}

class _AdmobBannerState extends State<AdmobBanner> {
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-2973886787176477/1663733242',
    size: const AdSize( height: 50, width: 300),
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  late AdWidget  adWidget  ;

   @override
  void initState() {
     adWidget = AdWidget(ad:  myBanner);
     myBanner.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
        alignment: Alignment.center,
        child: adWidget,
        width: myBanner.size.width.toDouble(),
    height: myBanner.size.height.toDouble(),
    );
  }

}