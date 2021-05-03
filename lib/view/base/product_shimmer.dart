import 'package:flutter/material.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/view/base/rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmer extends StatelessWidget {
  final bool isEnabled;
  ProductShimmer({@required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
      margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey[200], blurRadius: 10, spreadRadius: 1)],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: isEnabled,
        child: Row(children: [
          Container(
            height: 70, width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.COLOR_WHITE,
            ),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(height: 15, width: double.maxFinite, color: ColorResources.COLOR_WHITE),
            SizedBox(height: 5),
            RatingBar(rating: 0.0, size: 12),
            SizedBox(height: 10),
            Container(height: 10, width: 50, color: ColorResources.COLOR_WHITE),
          ])),
          SizedBox(width: 10),

          Column(children: [
            Icon(Icons.favorite_border, color: ColorResources.COLOR_GREY),
            Expanded(child: SizedBox()),
            Icon(Icons.add, color: ColorResources.COLOR_BLACK),
          ]),

        ]),
      ),
    );
  }
}
