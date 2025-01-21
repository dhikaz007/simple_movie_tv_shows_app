part of 'helpers.dart';

class SizeConfig {
  static late Size _mediaQuerySize;
  static late EdgeInsets _mediaQueryPadding;
  static late Orientation _mediaQueryOrientation;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static late bool isLandscape;

  void init(BuildContext context) {
    _mediaQuerySize = MediaQuery.sizeOf(context);
    _mediaQueryPadding = MediaQuery.paddingOf(context);
    _mediaQueryOrientation = MediaQuery.orientationOf(context);

    screenWidth = _mediaQuerySize.width;
    screenHeight = _mediaQuerySize.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryPadding.left + _mediaQueryPadding.right;
    _safeAreaVertical = _mediaQueryPadding.top + _mediaQueryPadding.bottom;

    isLandscape = (_mediaQueryOrientation == Orientation.landscape);
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

double sizeQuery(double x) {
  return (SizeConfig.isLandscape
          ? SizeConfig.safeBlockVertical
          : SizeConfig.safeBlockHorizontal) *
      x;
}

bool isLandscape() => SizeConfig.isLandscape;
