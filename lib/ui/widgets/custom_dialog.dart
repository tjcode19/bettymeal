import 'dart:ui';
import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String? title, textNeg, textPos;
  final Widget descriptions;
  final Image? img;
  final posAction;
  final Color? posColor;

  const CustomDialogBox(
      {Key? key,
      this.title,
      required this.descriptions,
      this.textPos,
      this.textNeg,
      this.posColor,
      this.img,
      this.posAction})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title!,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              widget.descriptions,
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        widget.textNeg!,
                        style: TextStyle(fontSize: 18),
                      )),
                  ElevatedButton(
                      onPressed: widget.posAction,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: widget.posColor ??
                              AppColour(context).primaryColour),
                      child: Text(
                        widget.textPos!,
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColour(context).onPrimaryColour),
                      )),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            // backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/images/6.png")),
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
