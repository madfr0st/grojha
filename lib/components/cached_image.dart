import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class CachedImage extends StatelessWidget {
  final String url;

  const CachedImage({
    Key key, this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder:
            (context, url, downloadProgress) =>
            Container(
              height: getProportionateScreenWidth(20),
              width: getProportionateScreenWidth(20),
              child: Center(child: CircularProgressIndicator(
                  color: kPrimaryColor,
                  value: downloadProgress.progress),
              ),),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          color: kPrimaryColor,
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}


class CachedImage_1 extends StatelessWidget {
  final String url;

  const CachedImage_1({
    Key key, this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder:
            (context, url, downloadProgress) =>
            Container(
              height: getProportionateScreenWidth(20),
              width: getProportionateScreenWidth(20),
              child: Center(child: CircularProgressIndicator(
                  color: kPrimaryColor,
                  value: downloadProgress.progress),
              ),),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          color: kPrimaryColor,
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}