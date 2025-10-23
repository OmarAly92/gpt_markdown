import 'package:flutter/material.dart';

/// A configuration class for the GPT Markdown component.
///
/// The [GptMarkdownConfig] class is used to configure the GPT Markdown component.
/// It takes a [style] parameter to set the style of the text,
/// a [textDirection] parameter to set the direction of the text,
/// and an optional [onLinkTab] parameter to handle link clicks.
class GptMarkdownConfig {
  const GptMarkdownConfig({
    this.style,
    this.textDirection = TextDirection.ltr,
    this.onLinkTab,
    this.textAlign,
    this.textScaler,
    this.latexWorkaround,
    this.latexBuilder,
    this.followLinkColor = false,
    this.codeBuilder,
    this.sourceTagBuilder,
    this.highlightBuilder,
    this.linkBuilder,
    this.imageBuilder,
    this.maxLines,
    this.overflow,
    this.highlightedText,
    this.caseSensitiveHighlight = false,
  });

  /// The direction of the text.
  final TextDirection textDirection;

  /// The style of the text.
  final TextStyle? style;

  /// The alignment of the text.
  final TextAlign? textAlign;

  /// The text scaler.
  final TextScaler? textScaler;

  /// The callback function to handle link clicks.
  final void Function(String url, String title)? onLinkTab;

  /// The LaTeX workaround.
  final String Function(String tex)? latexWorkaround;

  /// The text to highlight in the markdown content.
  final String? highlightedText;

  /// Whether to use case-sensitive highlighting.
  /// Defaults to false (case-insensitive).
  final bool caseSensitiveHighlight;

  /// The LaTeX builder.
  final Widget Function(
    BuildContext context,
    String tex,
    TextStyle textStyle,
    bool inline,
  )?
  latexBuilder;

  /// The source tag builder.
  final Widget Function(
    BuildContext context,
    String content,
    TextStyle textStyle,
  )?
  sourceTagBuilder;

  /// Whether to follow the link color.
  final bool followLinkColor;

  /// The code builder.
  final Widget Function(
    BuildContext context,
    String name,
    String code,
    bool closed,
  )?
  codeBuilder;

  /// The maximum number of lines.
  final int? maxLines;

  /// The overflow.
  final TextOverflow? overflow;

  /// The highlight builder.
  final Widget Function(BuildContext context, String text, TextStyle style)?
  highlightBuilder;
  final Widget Function(
    BuildContext context,
    String text,
    String url,
    TextStyle style,
  )?
  linkBuilder;

  /// The image builder.
  final Widget Function(BuildContext, String imageUrl)? imageBuilder;

  /// A copy of the configuration with the specified parameters.
  GptMarkdownConfig copyWith({
    TextStyle? style,
    TextDirection? textDirection,
    final void Function(String url, String title)? onLinkTab,
    final TextAlign? textAlign,
    final TextScaler? textScaler,
    final String Function(String tex)? latexWorkaround,
    final Widget Function(
      BuildContext context,
      String tex,
      TextStyle textStyle,
      bool inline,
    )?
    latexBuilder,
    final Widget Function(
      BuildContext context,
      String content,
      TextStyle textStyle,
    )?
    sourceTagBuilder,
    bool? followLinkColor,
    final Widget Function(
      BuildContext context,
      String name,
      String code,
      bool closed,
    )?
    codeBuilder,
    final int? maxLines,
    final TextOverflow? overflow,
    final Widget Function(BuildContext context, String text, TextStyle style)?
    highlightBuilder,
    final Widget Function(
      BuildContext context,
      String text,
      String url,
      TextStyle style,
    )?
    linkBuilder,
    final Widget Function(BuildContext, String imageUrl)? imageBuilder,
    String? highlightedText,
    bool? caseSensitiveHighlight,
  }) {
    return GptMarkdownConfig(
      style: style ?? this.style,
      textDirection: textDirection ?? this.textDirection,
      onLinkTab: onLinkTab ?? this.onLinkTab,
      textAlign: textAlign ?? this.textAlign,
      textScaler: textScaler ?? this.textScaler,
      latexWorkaround: latexWorkaround ?? this.latexWorkaround,
      latexBuilder: latexBuilder ?? this.latexBuilder,
      followLinkColor: followLinkColor ?? this.followLinkColor,
      codeBuilder: codeBuilder ?? this.codeBuilder,
      sourceTagBuilder: sourceTagBuilder ?? this.sourceTagBuilder,
      maxLines: maxLines ?? this.maxLines,
      overflow: overflow ?? this.overflow,
      highlightBuilder: highlightBuilder ?? this.highlightBuilder,
      linkBuilder: linkBuilder ?? this.linkBuilder,
      imageBuilder: imageBuilder ?? this.imageBuilder,
      highlightedText: highlightedText ?? this.highlightedText,
      caseSensitiveHighlight: caseSensitiveHighlight ?? this.caseSensitiveHighlight,
    );
  }

  /// A method to get a rich text widget from an inline span.
  Text getRich(InlineSpan span) {
    return Text.rich(
      span,
      textDirection: textDirection,
      textScaler: textScaler,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
