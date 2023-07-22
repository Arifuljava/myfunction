import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// App icons.
String facebookIcon = "assets/icons/facebook.svg";
String appleIcon = "assets/icons/apple.svg";
String googleIcon = "assets/icons/google.svg";
String searchIcon = "assets/icons/search.svg";
String voiceIcon = "assets/icons/voice.svg";

//App Colors.
const Color primaryBlue = Color(0xff004368);
const Color kGray = Color(0xff767676);
const Color primaryBlack = Color(0xff484848);
const Color kWhiteColor = Colors.white;
Color kTextColor =  const Color(0xff000000).withOpacity(0.6);

// app Images
const String sPlashBackground = "assets/images/splash.jpg";
const String loginBackground = "assets/images/login_background_icon.jpg";
const String loginAppIcon = "assets/icons/login_app_icon.png";
const String appIcon = "assets/icons/app_icon.png";

// app fonts.
String pBold = "Poppins_Bold";
String pLight = "Poppins_Light";
String pMedium = "Poppins_Medium";
String pRegular = "Poppins_Regular";
String pSemiBold = "Poppins_SemiBold";

// fonts Declare
TextStyle titleLarge = TextStyle(
  fontFamily: pSemiBold,
  fontWeight: FontWeight.w700,
  fontSize: ScreenUtil().setSp(35),
  color: kTextColor,
);

TextStyle bodyMedium = TextStyle(
  fontFamily: pBold,
  fontWeight: FontWeight.w700,
  color: kTextColor,
  fontSize: ScreenUtil().setSp(22),
  letterSpacing: -0.26,
);

TextStyle bodySmall = TextStyle(
  fontFamily: pLight,
  letterSpacing: -0.23,
  fontSize: ScreenUtil().setSp(15),
  color: kTextColor,
);

class InputEditText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPass;
  final TextInputType textInputType;
  final Widget? prefix;
  final Widget? suffix;

  const InputEditText({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPass = false,
    required this.textInputType,
    this.prefix,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: 318.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            //spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (prefix != null) prefix!,
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: REdgeInsets.all(10),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: bodySmall,
              ),
              keyboardType: textInputType,
              obscureText: isPass,
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color buttonColor;

  const ReusableButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50.0,
    this.buttonColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        ),
        child: Text(
          text,
          style: TextStyle(fontFamily: pBold, fontSize: 20.sp),
        ),
      ),
    );
  }
}