// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ButtonType {
 

  apple,
  appleDark,

  google,
  googleDark,


}

enum ImagePosition {
  left,
  right,
}

enum ButtonSize {
  small,
  medium,
  large,
}


// ignore: must_be_immutable
class SignInButton extends StatelessWidget {
  // required
  /// [buttonType] sets the style and icons of the button.
  ButtonType buttonType;

  // required
  /// [onPressed] Send a function to trigger the button.
  VoidCallback? onPressed;

  // not required, default left
  /// [imagePosition] set the position of the icon.(left or right)
  ImagePosition? imagePosition;

  // not required, default 5.0
  /// [elevation] set the button's elevation value.
  double elevation;

  // not required, default small
  /// [buttonSize] set the size of the button. (small medium large)
  ButtonSize buttonSize;

  // not required, Gets value according to buttonType.
  /// [btnColor] Set the background color of the button.
  Color? btnColor;

  // not required, Gets value according to buttonType.
  /// [btnDisabledColor] Set the background color of the disabled button.
  Color? btnDisabledColor;

  // not required, Gets value according to buttonType.
  /// [btnTextColor] set the button's text color.
  Color? btnTextColor;

  // not required, Gets value according to buttonType.
  /// [btnDisabledTextColor] set the disabled button's text color.
  Color? btnDisabledTextColor;

  // not required, Gets value according to buttonType.
  /// [btnText] set the button's text.
  String? btnText;

  // not required, Gets value according to buttonSize.
  /// You can change the value of [width] when the text size becomes too small.
  double? width;

  // not required, Gets value according to buttonSize.
  /// [padding] set the button's padding value.
  double? padding;

  /// [_image] value cannot be assigned.Gets value according to [buttonType].
  Widget? _image;

  /// [customImage] use to assign an image, otherwise [_image] is used
  // not required
  CustomImage? customImage;

  /// [_fontSize] value cannot be assigned.Gets value according to [buttonSize].
  double? _fontSize;

  /// [_imageSize] value cannot be assigned.Gets value according to [buttonSize].
  double? _imageSize;

  // not required, button shape.
  /// [shape] set the button's shape.
  ShapeBorder? shape;

  // not required, button model.
  /// [mini] It automatically takes value according to the selected constructor.
  bool mini;

  SignInButton({
    required this.buttonType,
    required this.onPressed,
    this.imagePosition = ImagePosition.left,
    this.buttonSize = ButtonSize.small,
    this.btnColor,
    this.btnDisabledColor,
    this.btnTextColor,
    this.btnDisabledTextColor,
    this.btnText,
    this.elevation = 5.0,
    this.width,
    this.padding,
    this.shape,
    this.customImage,
  }) : mini = false;

  SignInButton.mini({
    required this.buttonType,
    required this.onPressed,
    this.buttonSize = ButtonSize.small,
    this.btnColor,
    this.btnDisabledColor,
    this.elevation = 5.0,
    this.padding,
    this.customImage,
  }) : mini = true;

  bool get _enabled => onPressed != null;

  bool get _disabled => !_enabled;

  @override
  Widget build(BuildContext context) {
    _setButtonSize();
    _createStyle(context);
    return !mini
        ? MaterialButton(
            color: btnColor,
            disabledColor: btnDisabledColor,
            shape: shape ?? const StadiumBorder(),
            onPressed: onPressed,
            elevation: elevation,
            child: SizedBox(
              width: width,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: imagePosition == ImagePosition.left
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(padding!),
                    child:
                        imagePosition == ImagePosition.left ? _image : _text(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding!),
                    child:
                        imagePosition == ImagePosition.left ? _text() : _image,
                  ),
                ],
              ),
            ),
          )
        : MaterialButton(
            onPressed: onPressed,
            color: btnColor,
            disabledColor: btnDisabledColor,
            elevation: elevation,
            padding: EdgeInsets.all(padding!),
            shape: const CircleBorder(),
            child: _image,
          );
  }

  Widget _text() {
    return Text(
      btnText!,
      style: TextStyle(
        fontSize: _fontSize,
        color: _enabled ? btnTextColor : btnDisabledTextColor,
      ),
    );
  }

  void _setButtonSize() {
    if (buttonSize == ButtonSize.small) {
      padding ??= !mini ? 5.0 : 6.0;
      width ??= 200;
      _fontSize = 15.0;
      _imageSize = !mini ? 24.0 : 30.0;
    } else if (buttonSize == ButtonSize.medium) {
      padding ??= !mini ? 5.5 : 6.5;
      width ??= 220;
      _fontSize = 17.0;
      _imageSize = !mini ? 28.0 : 34.0;
    } else {
      padding ??= !mini ? 6.0 : 7.0;
      width ??= 250;
      _fontSize = 19.0;
      _imageSize = !mini ? 32.0 : 38.0;
    }
  }

void _createStyle(BuildContext context) {
  btnDisabledColor ??= Theme.of(context).disabledColor.withOpacity(0.12);
  btnDisabledTextColor ??= Theme.of(context).disabledColor.withOpacity(0.38);

  _image = Image.asset(
    customImage?.imagePath ?? 'assets/images/${describeEnum(buttonType)}.png',
    width: _imageSize,
    height: _imageSize,
  );


    if (_disabled) {
      _image = ColorFiltered(
        colorFilter: const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0, // R1
          0.2126, 0.7152, 0.0722, 0, 0, // R2
          0.2126, 0.7152, 0.0722, 0, 0, // R3
          0, 0, 0, 1, 0, // R4
        ]),
        child: _image,
      );
    }

    switch (buttonType) {
  
      case ButtonType.apple:
        btnText ??= 'Sign in with Apple';
        btnTextColor ??= Colors.black;
        btnColor ??= const Color(0xfff7f7f7);
        break;

      case ButtonType.appleDark:
        btnText ??= 'Sign in with Apple';
        btnTextColor ??= Colors.white;
        btnColor ??= Colors.black;
        break;

      case ButtonType.google:
        btnText ??= 'Sign in with Google';
        btnTextColor ??= Colors.black;
        btnColor ??= const Color(0xfff7f7f7);
        break;

      case ButtonType.googleDark:
        btnText ??= 'Sign in with Google';
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFF4285F4);
        break;

    }
  }
}

class CustomImage {
  /// [imagePath] Assign path to image
  String imagePath;

  /// [package] If you want to access it from a different module, pass the package value.
  // not required
  String? package;

  CustomImage(this.imagePath, {this.package});
}