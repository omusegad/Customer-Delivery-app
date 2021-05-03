import 'package:flutter/material.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/provider/auth_provider.dart';
import 'package:flutter_restaurant/provider/wishlist_provider.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/view/base/custom_app_bar.dart';
import 'package:flutter_restaurant/view/base/no_data_screen.dart';
import 'package:flutter_restaurant/view/base/not_logged_in_screen.dart';
import 'package:flutter_restaurant/view/base/product_widget.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final bool _isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('my_favourite', context), isBackButtonExist: false),
      body: _isLoggedIn ? Consumer<WishListProvider>(
        builder: (context, wishlistProvider, child) {
          return wishlistProvider.wishList != null ? wishlistProvider.wishIdList.length > 0 ? RefreshIndicator(
            onRefresh: () async {
              await Provider.of<WishListProvider>(context, listen: false).initWishList(context);
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: ListView.builder(
              itemCount: wishlistProvider.wishList.length,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              itemBuilder: (context, index) {
                return ProductWidget(product: wishlistProvider.wishList[index]);
              },
            ),
          ): NoDataScreen()
            : Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(ColorResources.COLOR_PRIMARY)));
        },
      ) : NotLoggedInScreen(),
    );
  }
}
