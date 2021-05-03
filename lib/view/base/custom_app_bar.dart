import 'package:flutter/material.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final Function onBackPressed;
  CustomAppBar({@required this.title, this.isBackButtonExist = true, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).textTheme.bodyText1.color)),
      centerTitle: true,
      leading: isBackButtonExist ? IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Theme.of(context).textTheme.bodyText1.color,
        onPressed: () => onBackPressed != null ? onBackPressed() : Navigator.pop(context),
      ) : SizedBox(),
      backgroundColor: Theme.of(context).accentColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 50);
}
