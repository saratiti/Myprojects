import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color red400 = fromHex('#eb5757');

  static Color green600 = fromHex('#27ae60');

  static Color whiteA70033 = fromHex('#33ffffff');

  static Color whiteA70099 = fromHex('#99ffffff');

  static Color black900 = fromHex('#000000');

  static Color blueGray900 = fromHex('#333333');

  static Color redA700 = fromHex('#f80000');

  static Color green60072 = fromHex('#722aa952');

  static Color gray600 = fromHex('#828282');

  static Color amber800 = fromHex('#ff8c00');

  static Color black9004c = fromHex('#4c000000');

  static Color gray400 = fromHex('#bdbdbd');

  static Color gray500 = fromHex('#9b9b9b');

  static Color blueGray400 = fromHex('#8e8e92');

  static Color gray800 = fromHex('#4f4f4f');

  static Color whiteA700A2 = fromHex('#a2ffffff');

  static Color blue600 = fromHex('#2d9cdb');

  static Color gray900 = fromHex('#222222');

  static Color black9000f = fromHex('#0f000000');

  static Color black9000c = fromHex('#0c000000');

  static Color gray200 = fromHex('#f0f0f0');

  static Color gray300 = fromHex('#e0e0e0');

  static Color gray100 = fromHex('#f2f2f2');

  static Color whiteA70066 = fromHex('#66ffffff');

  static Color black900Cc = fromHex('#cc000000');

  static Color gray40001 = fromHex('#c4c4c4');

  static Color black90019 = fromHex('#19000000');

  static Color green60001 = fromHex('#2aa952');

  static Color black90014 = fromHex('#14000000');

  static Color blueGray40001 = fromHex('#888888');

  static Color whiteA700 = fromHex('#ffffff');
    static const darkOrange = Color(0xFFEC6813);
  static const lightOrange = Color(0xFFf8b89a);

  static const darkGrey = Color(0xFFA6A3A0);
  static const lightGrey = Color(0xFFE5E6E8);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
