import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/provider/auth_provider.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/styles.dart';
import 'package:flutter_restaurant/view/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        SizedBox(height: 20),
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.contact_support, size: 50),
        ),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Text(getTranslated('want_to_sign_out', context), style: rubikBold, textAlign: TextAlign.center),
        ),

        Divider(height: 0, color: ColorResources.getHintColor(context)),
        Row(children: [

          Expanded(child: InkWell(
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).clearSharedData().then((condition) {
                Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SplashScreen()), (route) => false);
              });
            },
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
              child: Text(getTranslated('yes', context), style: rubikBold.copyWith(color: ColorResources.COLOR_PRIMARY)),
            ),
          )),

          Expanded(child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorResources.getPrimaryColor(context), borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Text(getTranslated('no', context), style: rubikBold.copyWith(color: Colors.white)),
            ),
          )),

        ]),
      ]),
    );
  }
}
