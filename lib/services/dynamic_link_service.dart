

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/home/home_screen.dart';
import 'package:grojha/screens/single_shop/single_shop.dart';

import '../locator.dart';


class DynamicLinkService {

  String previousLink = "";

  Future handleDynamicLinks(BuildContext context,Function function) async {
    // Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    await Future.delayed(Duration(seconds: 1),(){
      _handleDeepLink(data,context,function);

      // Register a link callback to fire if the app is opened up from the background
      // using a dynamic link.
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
            // handle link that has been retrieved
            _handleDeepLink(dynamicLink,context,function);
          }, onError: (OnLinkErrorException e) async {
        print('Link Failed: ${e.message}');
      });
    });


  }

  void _handleDeepLink(PendingDynamicLinkData data,BuildContext context,Function function) {
    if(data!=null) {
      final Uri deepLink = data.link;
      if (deepLink != null) {
        debugPrint('_handleDeepLink | deeplink: $deepLink');
        var isPost = deepLink.pathSegments.contains('post');
        if (isPost) {
          var title = deepLink.queryParameters['shop_id'];
          if (title != null && title!=previousLink) {
            previousLink = title;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SingleShop(notifyHomeScreen: function,
                          shop: Shop(shopId: title, shopName: "check"
                            //notifyHomeScreen: _refresh,
                          ),
                        )));
          }
        }
      }
    }
  }

  Future<String> createFirstPostLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://projectred.page.link',
      link: Uri.parse('https://www.grojha.com/post?shop_id=LVFggWiBrfgR2ayPSdSQF7PGNY33'),
      androidParameters: AndroidParameters(
        packageName: 'com.grojha.grojha',
      ),

      // Other things to add as an example. We don't need it now
      iosParameters: IosParameters(
        bundleId: 'com.example.ios',
        minimumVersion: '1.0.1',
        appStoreId: '123456789',
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'example-promo',
        medium: 'social',
        source: 'orkut',
      ),
      itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
        providerToken: '123456',
        campaignToken: 'example-promo',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Example of a Dynamic Link',
        description: 'This link works whether app is installed or not!',
      ),
    );

    final Uri dynamicUrl = await parameters.buildUrl();

    //debugPrint(dynamicUrl.toString());

    return dynamicUrl.toString();
  }
}
