import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:self_check_3/resource/theme/app_color.dart';

class GlobalWidgets {
  static Widget button(
          {Function()? onTap,
          required Widget child,
          EdgeInsets edgeInsets = EdgeInsets.zero,
          Color color = AppColor.clear,
          double cornerRadius = 0}) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: Material(
          color: color,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: edgeInsets,
              child: child,
            ),
          ),
        ),
      );

  static Widget rButton(
          {Function()? onTap,
          required Widget child,
          EdgeInsets edgeInsets = EdgeInsets.zero,
          Color color = AppColor.clear,
          double cornerRadius = 4}) =>
      button(
          child: child,
          onTap: onTap,
          edgeInsets: edgeInsets,
          color: color,
          cornerRadius: cornerRadius);

  static Widget koreanBreakText(String txt, {TextStyle? style}) => Wrap(
      children: txt
          .split(' ')
          .map((x) => Text("$x ",
              style: style ?? Theme.of(Get.context!).textTheme.bodyText2))
          .toList());

  @Deprecated("change to another one")
  static Widget alignText(String txt, {TextStyle? style}) =>
      Align(alignment: Alignment.centerLeft, child: Text(txt, style: style));

  @Deprecated("change to non-shadow button")
  static Widget roundedButtonWithShadow(String str, Function() onTap,
          {Color backColor = const Color(0xFF343434),
          Color? splashColor,
          FontWeight? fontWeight = FontWeight.w700,
          Color? textColor = Colors.white}) =>
      Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(2, 4),
                    blurRadius: 4.0,
                    spreadRadius: 2.0)
              ]),
          child: button(
              onTap: onTap,
              edgeInsets: const EdgeInsets.symmetric(vertical: 16),
              color: backColor,
              cornerRadius: 100,
              child: Text(
                str,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor, fontSize: 14, fontWeight: fontWeight),
              )));

  static Widget _bottomContainer(List<Widget> widgets) => Wrap(
      children: [
        ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(24),
                topRight: const Radius.circular(24)),
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 24),
                color: Colors.white,
                child: Column(children: widgets)))
      ]);

  static Widget noticeBottomSheet(String noticeHtml) => _bottomContainer([
        Text(tr("notice_title"),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: HtmlWidget(noticeHtml,
              textStyle: TextStyle(
                  fontFamily: 'spoqa',
                  fontWeight: FontWeight.normal,
                  color: AppColor.onSecondary)),
        ),
        SizedBox(
            width: MediaQuery.of(Get.context!).size.width,
            child: button(
                onTap: Get.back,
                color: AppColor.primary,
                edgeInsets: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  tr("ok"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColor.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )))
      ]);
}
