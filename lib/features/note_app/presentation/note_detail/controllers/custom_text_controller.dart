import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/data/custom_text_span.dart';
import '../../../../../core/data/formatting_rules.dart';

class CustomTextController extends TextEditingController {
  final Map<String, TextStyle> formattingRules = CustomFormattingRules.styles;

  CustomTextController({String? text}) : super(text: text);

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing,
      bool showTags = true}) {
    final List<InlineSpan> children = [];

    final RegExp regExp =
        // r'\[\[(.*?)\]\](.*?)\[\[\/\1\]\]'
        // r'\[\[(.*?)\]\](.*?)\[\[\1\]\]'
        RegExp(r'\[\[(.*?)\]\](.*?)\[\[/\1\]\]', multiLine: true);

    String text = this.text;
    int lastIndex = 0;
    // Get.log("Text custom TextController: $text");
    // Get.log("matches custom TextController: ${regExp.allMatches(text)}");
    for (final Match m in regExp.allMatches(text)) {
      Get.log("Match custom TextController: ${m.group(0)}");
      if (m.start > lastIndex) {
        children.add(TextSpan(
          text: text.substring(lastIndex, m.start),
          style: style,
        ));
      }

      String formatType = m.group(1)!;
      String content = m.group(2)!;

      TextStyle? customStyle = formattingRules[formatType] ?? style;
      Get.log("Example Content: ${m.group(0)}");

      if (showTags) {
        children.add(TextSpan(
          text: "[[$formatType]]",
          style: style,
        ));
        children.add(TextSpan(
          text: content,
          style: customStyle,
        ));
        children.add(TextSpan(
          text: "[[/$formatType]]",
          style: style,
        ));
      } else {
        children.add(TextSpan(
          text: content,
          style: customStyle,
        ));
      }
      lastIndex = m.end;
    }

    if (lastIndex < text.length) {
      children.add(TextSpan(
        text: text.substring(lastIndex),
        style: style,
      ));
    }

    return TextSpan(children: children, style: style);
  }
}
