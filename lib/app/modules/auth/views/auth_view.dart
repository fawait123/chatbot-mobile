import 'dart:ui';

import 'package:apps_consultation_pregnant/app/components/text_input/default_text_input.dart';
import 'package:apps_consultation_pregnant/app/core/constants/constant_asset.dart';
import 'package:apps_consultation_pregnant/app/core/styles/style_text.dart';
import 'package:apps_consultation_pregnant/app/modules/auth/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../components/button/custom_button_submit.dart';
import '../../../core/styles/style_color.dart';
import '../../home/views/home_view.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AuthController(),
      builder: (controller) {
        return Scaffold(
            body: SingleChildScrollView(
          physics: PageScrollPhysics(),
          child: Container(
            width: Get.width,
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.35,
                  width: Get.width,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.25,
                          decoration: BoxDecoration(
                            color: CustomColor.primaryColor.withOpacity(0.8),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.elliptical(
                                  Get.width * 0.5, Get.width * 0.2),
                              bottomRight: Radius.elliptical(
                                  Get.width * 0.5, Get.width * 0.2),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: Get.height * 0.33 - (Get.width * 0.5),
                        bottom: -20,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          ConstantAsset.iconApp,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: controller.keyForm,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        DefaultTextInput(
                          controller: controller.usernameController,
                          hintText: 'Username',
                          keyboardType: TextInputType.text,
                          textStyle: CustomText.Regular(
                              fontSize: 16.0,
                              colorText:
                                  CustomColor.greyColor.withOpacity(0.5)),
                        ),
                        Gap(15),
                        TextFormField(
                          style: CustomText.Regular(
                              fontSize: 16.0,
                              colorText:
                                  CustomColor.greyColor.withOpacity(0.5)),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please fill in correctly!';
                            }
                          },
                          obscureText: controller.isObscure,
                          obscuringCharacter: '*',
                          controller: controller.passwordController,
                          cursorColor: CustomColor.greyColor,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Password',
                            hintStyle: CustomText.Regular(
                                fontSize: 16.0,
                                colorText:
                                    CustomColor.greyColor.withOpacity(0.5)),
                            fillColor: CustomColor.whiteColor,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 18),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.showPassword();
                                },
                                icon: Icon(
                                  controller.isObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                                color: CustomColor.greyColor),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                    color: CustomColor.greyColor, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                    color: CustomColor.greyColor, width: 1)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: CustomColor.greyColor, width: 1),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: CustomColor.greyColor, width: 1),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: CustomColor.greyColor, width: 1),
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                        Gap(30),
                        CustomButtonSubmit(
                          onPressed: () {
                            if (controller.keyForm.currentState!.validate()) {
                              controller.postLogin();
                            }
                          },
                          title: 'Login',
                          isDisabled: false,
                          height: 15,
                        ),
                        Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(RegisterView());
                              },
                              child: Text(
                                'Don`t have an account?',
                                style: TextStyle(
                                  fontFamily: 'RobotoRegular',
                                  color: CustomColor.blackColor,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
