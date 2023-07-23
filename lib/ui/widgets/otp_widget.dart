import 'dart:async';

import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOtpField extends StatefulWidget {
  final dynamic completeAction;
  final int? length;
  final TextEditingController? txtEditingController;
  final dynamic focusNode;
  final dynamic validator;
  const CustomOtpField(
      {Key? key,
      @required this.completeAction,
      this.length = 6,
      this.txtEditingController,
      this.validator,
      this.focusNode})
      : super(key: key);

  @override
  _CustomOtpFieldState createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  // final completeAction;
  // _CustomOtpFieldState({this.completeAction});
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  // @override
  // void dispose() {
  //   // errorController!.close();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: TextStyle(
        color: AppColour(context).secondaryColour,
        fontWeight: FontWeight.bold,
      ),
      length: widget.length!,
      obscureText: true,
      obscuringCharacter: '*',
      // obscuringWidget: Image.asset(
      //   'assets/images/logo.png',
      //   width: 24,
      //   height: 24,
      // ),
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: widget.validator,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 50,
          fieldWidth: 40,
          borderWidth: 1.0,
          selectedColor: AppColour(context).secondaryColour,
          disabledColor: AppColour(context).primaryColour,
          activeFillColor: Colors.white,
          inactiveColor: AppColour(context).onSecondaryColour.withOpacity(0.4),
          activeColor: AppColour(context).secondaryColour.withOpacity(0.6)),
      cursorColor: AppColour(context).secondaryColour,
      animationDuration: const Duration(milliseconds: 200),
      enableActiveFill: false,
      errorAnimationController: errorController,
      controller: widget.txtEditingController,
      keyboardType: TextInputType.number,
      focusNode: widget.focusNode,
      // boxShadows: [
      //   BoxShadow(
      //     offset: Offset(0, 1),
      //     color: Colors.black12,
      //     blurRadius: 10,
      //   )
      // ],
      onCompleted: widget.completeAction,
      // onTap: () {
      //   print("Pressed");
      // },
      onChanged: (value) {
        setState(() {
          currentText = value;
        });
      },
      beforeTextPaste: (text) {
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
