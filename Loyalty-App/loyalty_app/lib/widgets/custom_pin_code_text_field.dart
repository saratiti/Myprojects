// ignore_for_file: must_be_immutable




import 'package:loyalty_app/core/app_export.dart';

class CustomPinCodeTextField extends StatelessWidget {
  CustomPinCodeTextField({
    Key? key,
    required this.context,
    required this.onChanged,
    this.alignment,
    this.margin,
    this.controller,
    this.textStyle,
    this.hintStyle,
    this.validator,
    required this.onPinFilled,
  }) : super(key: key);

  final Function(String) onPinFilled;
  final Alignment? alignment;
  final EdgeInsetsGeometry? margin;
  final BuildContext context;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  Function(String) onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget,
          )
        : pinCodeTextFieldWidget;
  }

 Widget get pinCodeTextFieldWidget => Padding(
  padding: margin ?? EdgeInsets.zero,
  child: PinCodeTextField(
    appContext: context,
    controller: controller,
    length: 6,
    keyboardType: TextInputType.number,
    textStyle: textStyle,
    hintStyle: hintStyle,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
    ],
    enableActiveFill: true,
    pinTheme: PinTheme(
  fieldHeight: 42.h,
  fieldWidth: 38.h,
  shape: PinCodeFieldShape.box,
  borderRadius: BorderRadius.circular(8.h), // Set border radius
  borderWidth: 2.0, // Set the width of the border
  inactiveColor: appTheme.deepOrange800,
  activeColor: appTheme.deepOrange800,
  inactiveFillColor: appTheme.gray100,
  activeFillColor: appTheme.gray100,
  selectedFillColor: appTheme.deepOrange800,
  selectedColor:  appTheme.deepOrange800,
  disabledColor:  appTheme.deepOrange800,

),




    onChanged: (value) => onChanged(value),
    onCompleted: (pin) {
      onPinFilled(pin);
    },
    validator: validator,
  ),
);
}