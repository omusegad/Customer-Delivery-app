import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/model/response/cart_model.dart';
import 'package:flutter_restaurant/data/model/response/product_model.dart';
import 'package:flutter_restaurant/helper/price_converter.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/provider/splash_provider.dart';
import 'package:flutter_restaurant/provider/theme_provider.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/images.dart';
import 'package:flutter_restaurant/utill/styles.dart';
import 'package:flutter_restaurant/view/base/rating_bar.dart';
import 'package:flutter_restaurant/view/screens/home/widget/cart_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  ProductWidget({@required this.product});

  @override
  Widget build(BuildContext context) {

    double _startingPrice;
    double _endingPrice;
    if(product.choiceOptions.length != 0) {
      List<double> _priceList = [];
      product.variations.forEach((variation) => _priceList.add(variation.price));
      _priceList.sort((a, b) => a.compareTo(b));
      _startingPrice = _priceList[0];
      if(_priceList[0] < _priceList[_priceList.length-1]) {
        _endingPrice = _priceList[_priceList.length-1];
      }
    }else {
      _startingPrice = product.price;
    }

    double _discountedPrice = PriceConverter.convertWithDiscount(context, product.price, product.discount, product.discountType);

    DateTime _currentTime = Provider.of<SplashProvider>(context, listen: false).currentTime;
    DateTime _start = DateFormat('hh:mm:ss').parse(product.availableTimeStarts);
    DateTime _end = DateFormat('hh:mm:ss').parse(product.availableTimeEnds);
    DateTime _startTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _start.hour, _start.minute, _start.second);
    DateTime _endTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _end.hour, _end.minute, _end.second);
    if(_endTime.isBefore(_startTime)) {
      _endTime = _endTime.add(Duration(days: 1));
    }
    bool _isAvailable = _currentTime.isAfter(_startTime) && _currentTime.isBefore(_endTime);

    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (con) => CartBottomSheet(
              product: product,
              callback: (CartModel cartModel) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('added_to_cart', context)), backgroundColor: Colors.green));
              },
            ),
        );
      },
      child: Container(
        height: 85,
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
            color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300],
            blurRadius: 5, spreadRadius: 1,
          )],
        ),
        child: Row(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder_image,
                  image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${product.image}',
                  height: 70,
                  width: 85,
                  fit: BoxFit.cover,
                ),
              ),
              _isAvailable ? SizedBox() : Positioned(
                top: 0, left: 0, bottom: 0, right: 0,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black.withOpacity(0.6)),
                  child: Text(getTranslated('not_available_now_break', context), textAlign: TextAlign.center, style: rubikRegular.copyWith(
                    color: Colors.white, fontSize: 8,
                  )),
                ),
              ),
            ],
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(product.name, style: rubikMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
              SizedBox(height: 10),
              Text(
                '${PriceConverter.convertPrice(context, _startingPrice, discount: product.discount, discountType: product.discountType, asFixed: 1)}'
                    '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: product.discount,
                    discountType: product.discountType, asFixed: 1)}' : ''}',
                style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
              ),
              product.price > _discountedPrice ? Text('${PriceConverter.convertPrice(context, _startingPrice, asFixed: 1)}'
                  '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, asFixed: 1)}' : ''}', style: rubikMedium.copyWith(
                color: ColorResources.COLOR_GREY,
                decoration: TextDecoration.lineThrough,
                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
              )) : SizedBox(),
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Icon(Icons.add),
            Expanded(child: SizedBox()),
            RatingBar(rating: product.rating.length > 0 ? double.parse(product.rating[0].average) : 0.0, size: 10),
          ]),
        ]),
      ),
    );
  }
}
