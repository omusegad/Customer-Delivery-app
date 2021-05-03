import 'package:flutter/material.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/provider/auth_provider.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/images.dart';
import 'package:flutter_restaurant/view/base/custom_app_bar.dart';
import 'package:flutter_restaurant/view/base/custom_button.dart';
import 'package:flutter_restaurant/view/base/custom_snackbar.dart';
import 'package:flutter_restaurant/view/screens/auth/create_account_screen.dart';
import 'package:flutter_restaurant/view/screens/forgot_password/create_new_password_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatelessWidget {
  final String emailAddress;
  final bool fromSignUp;
  VerificationScreen({@required this.emailAddress, this.fromSignUp = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('verify_email', context)),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 55),
              Image.asset(
                Images.email_with_background,
                width: 142,
                height: 142,
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                    child: Text(
                  '${getTranslated('please_enter_4_digit_code', context)}\n $emailAddress',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 35),
                child: PinCodeTextField(
                  length: 4,
                  appContext: context,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 63,
                    fieldWidth: 55,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(10),
                    selectedColor: ColorResources.colorMap[200],
                    selectedFillColor: Colors.white,
                    inactiveFillColor: ColorResources.getSearchBg(context),
                    inactiveColor: ColorResources.colorMap[200],
                    activeColor: ColorResources.colorMap[400],
                    activeFillColor: ColorResources.getSearchBg(context),
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: authProvider.updateVerificationCode,
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
              Center(
                  child: Text(
                getTranslated('i_didnt_receive_the_code', context),
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: ColorResources.getGreyBunkerColor(context),
                    ),
              )),
              Center(
                child: InkWell(
                  onTap: () {
                    if(fromSignUp) {
                      Provider.of<AuthProvider>(context, listen: false).checkEmail(emailAddress).then((value) {
                        if (value.isSuccess) {
                          showCustomSnackBar('Resent code successful', context, isError: false);
                        } else {
                          showCustomSnackBar(value.message, context);
                        }
                      });
                    }else {
                      Provider.of<AuthProvider>(context, listen: false).forgetPassword(emailAddress).then((value) {
                        if (value.isSuccess) {
                          showCustomSnackBar('Resent code successful', context, isError: false);
                        } else {
                          showCustomSnackBar(value.message, context);
                        }
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Text(
                      getTranslated('resend_code', context),
                      style: Theme.of(context).textTheme.headline3.copyWith(
                            color: ColorResources.getGreyBunkerColor(context),
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48),
              authProvider.isEnableVerificationCode ? !authProvider.isPhoneNumberVerificationButtonLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                      child: CustomButton(
                        btnTxt: getTranslated('verify', context),
                        onTap: () {
                          if(fromSignUp) {
                            Provider.of<AuthProvider>(context, listen: false).verifyEmail(emailAddress).then((value) {
                              if(value.isSuccess) {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateAccountScreen()));
                              }else {
                                showCustomSnackBar(value.message, context);
                              }
                            });
                          }else {
                            Provider.of<AuthProvider>(context, listen: false).verifyToken(emailAddress).then((value) {
                              if(value.isSuccess) {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateNewPasswordScreen(
                                  email: emailAddress,
                                  resetToken: authProvider.verificationCode,
                                )));
                              }else {
                                showCustomSnackBar(value.message, context);
                              }
                            });
                          }
                        },
                      ),
                    ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
