import 'package:flutter/material.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/provider/auth_provider.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/images.dart';
import 'package:flutter_restaurant/view/base/custom_app_bar.dart';
import 'package:flutter_restaurant/view/base/custom_button.dart';
import 'package:flutter_restaurant/view/base/custom_snackbar.dart';
import 'package:flutter_restaurant/view/base/custom_text_field.dart';
import 'package:flutter_restaurant/view/screens/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  final String resetToken;
  final String email;
  CreateNewPasswordScreen({required this.resetToken, required this.email});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('create_new_password', context)),
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 55),
              Image.asset(
                Images.open_lock,
                width: 142,
                height: 142,
              ),
              SizedBox(height: 40),
              Center(
                  child: Text(
                    getTranslated('enter_password_to_create', context)!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorResources.getHintColor(context)),
                  )),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // for password section

                    SizedBox(height: 60),
                    Text(
                      getTranslated('new_password', context)!,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    CustomTextField(
                      hintText: getTranslated('password_hint', context),
                      isShowBorder: true,
                      isPassword: true,
                      focusNode: _passwordFocus,
                      nextFocus: _confirmPasswordFocus,
                      isShowSuffixIcon: true,
                      inputAction: TextInputAction.next,
                      controller: _passwordController,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    // for confirm password section
                    Text(
                      getTranslated('confirm_password', context)!,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    CustomTextField(
                      hintText: getTranslated('password_hint', context),
                      isShowBorder: true,
                      isPassword: true,
                      isShowSuffixIcon: true,
                      focusNode: _confirmPasswordFocus,
                      controller: _confirmPasswordController,
                      inputAction: TextInputAction.done,
                    ),

                    SizedBox(height: 24),
                    !auth.isForgotPasswordLoading ? CustomButton(
                      btnTxt: getTranslated('save', context),
                      onTap: () {
                        if (_passwordController.text.isEmpty) {
                          showCustomSnackBar(getTranslated('enter_password', context)!, context);
                        }else if (_passwordController.text.length < 6) {
                          showCustomSnackBar(getTranslated('password_should_be', context)!, context);
                        }else if (_confirmPasswordController.text.isEmpty) {
                          showCustomSnackBar(getTranslated('enter_confirm_password', context)!, context);
                        }else if(_passwordController.text != _confirmPasswordController.text) {
                          showCustomSnackBar(getTranslated('password_did_not_match', context)!, context);
                        }else {
                          auth.resetPassword(resetToken, _passwordController.text, _confirmPasswordController.text).then((value) {
                            if(value.isSuccess) {
                              auth.login(email, _passwordController.text).then((value) {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => DashboardScreen()));
                              });
                            }else {
                              showCustomSnackBar('Failed to reset password', context);
                            }
                          });
                        }
                      },
                    ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
