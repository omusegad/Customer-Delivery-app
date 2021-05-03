import 'package:flutter/material.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/provider/category_provider.dart';
import 'package:flutter_restaurant/provider/splash_provider.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/images.dart';
import 'package:flutter_restaurant/utill/styles.dart';
import 'package:flutter_restaurant/view/base/title_widget.dart';
import 'package:flutter_restaurant/view/screens/category/category_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<CategoryProvider>(
      builder: (context, category, child) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
              child: TitleWidget(title: getTranslated('all_categories', context)),
            ),
            SizedBox(
              height: 80,
              child: category.categoryList != null ? category.categoryList.length > 0 ? ListView.builder(
                itemCount: category.categoryList.length,
                padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryScreen(categoryModel: category.categoryList[index]))),
                    child: Padding(
                      padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                      child: Column(children: [

                        ClipOval(
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder_image,
                            image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}/${category.categoryList[index].image}',
                            width: 65, height: 65, fit: BoxFit.cover,
                          ),
                        ),

                        Text(
                          category.categoryList[index].name,
                          style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      ]),
                    ),
                  );
                },
              ) : Center(child: Text(getTranslated('no_category_available', context))) : CategoryShimmer(),
            ),
          ],
        );
      },
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: Provider.of<CategoryProvider>(context).categoryList == null,
              child: Column(children: [
                Container(
                  height: 65, width: 65, 
                  decoration: BoxDecoration(
                    color: ColorResources.COLOR_WHITE,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 5),
                Container(height: 10, width: 50, color: ColorResources.COLOR_WHITE),
              ]),
            ),
          );
        },
      ),
    );
  }
}

