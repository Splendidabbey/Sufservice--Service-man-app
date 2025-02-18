import 'package:demandium_serviceman/utils/core_export.dart';

const ubuntuLight = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w300,
);

const ubuntuRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
);

TextStyle ubuntuRegularLow = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeSmall,
);

TextStyle ubuntuRegularMid = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

const ubuntuMedium = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
);

TextStyle ubuntuMediumLow = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeSmall,
);

TextStyle ubuntuMediumMid = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
);

TextStyle ubuntuMediumHigh = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeLarge,
);



const ubuntuBold = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w700,
);

TextStyle ubuntuBoldLow = TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w700,
    fontSize: Dimensions.fontSizeSmall
);

TextStyle ubuntuBoldMid = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault
);

TextStyle ubuntuBoldHigh = TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w700,
    fontSize: Dimensions.fontSizeExtraLarge
);


List<BoxShadow>? shadow =  [
  BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 2,
    color: Colors.black.withOpacity(0.15),
  )];

List<BoxShadow>? lightShadow = [
  const BoxShadow(
    offset: Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 1,
    color: Color(0x20D6D8E6),
  )];
