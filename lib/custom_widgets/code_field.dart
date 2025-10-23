import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that displays code with syntax highlighting and a copy button.
///
/// The [CodeField] widget takes a [name] parameter which is displayed as a label
/// above the code block, and a [codes] parameter containing the actual code text
/// to display.
///
/// Features:
/// - Displays code in a Material container with rounded corners
/// - Shows the code language/name as a label
/// - Provides a copy button to copy code to clipboard
/// - Visual feedback when code is copied
/// - Themed colors that adapt to light/dark mode
class CodeField extends StatefulWidget {
  const CodeField({
    super.key,
    required this.name,
    required this.codes,
    this.highlightedText,
    this.caseSensitiveHighlight = false,
  });
  final String name;
  final String codes;
  final String? highlightedText;
  final bool caseSensitiveHighlight;

  @override
  State<CodeField> createState() => _CodeFieldState();
}

class _CodeFieldState extends State<CodeField> {
  bool _copied = false;
  /// Builds the code text widget with optional search highlighting
  Widget _buildCodeText() {
    final codeStyle = TextStyle(
      fontFamily: 'JetBrainsMono',
      package: "gpt_markdown",
    );

    // If no highlighting is needed, return simple text
    if (widget.highlightedText == null || widget.highlightedText!.isEmpty) {
      return Text(widget.codes, style: codeStyle);
    }

    // Apply search highlighting
    final searchQuery = widget.caseSensitiveHighlight
        ? widget.highlightedText!
        : widget.highlightedText!.toLowerCase();
    final searchText = widget.caseSensitiveHighlight
        ? widget.codes
        : widget.codes.toLowerCase();

    if (!searchText.contains(searchQuery)) {
      return Text(widget.codes, style: codeStyle);
    }

    // Build spans with search highlighting
    final spans = <TextSpan>[];
    final originalQueryLength = widget.highlightedText!.length;
    int currentIndex = 0;
    int searchIndex = 0;

    while ((searchIndex = searchText.indexOf(searchQuery, currentIndex)) != -1) {
      // Add text before highlight
      if (searchIndex > currentIndex) {
        spans.add(
          TextSpan(
            text: widget.codes.substring(currentIndex, searchIndex),
            style: codeStyle,
          ),
        );
      }

      // Add highlighted text with yellow background
      spans.add(
        TextSpan(
          text: widget.codes.substring(searchIndex, searchIndex + originalQueryLength),
          style: codeStyle.copyWith(
            color: Colors.black,
            backgroundColor: Colors.yellow,
          ),
        ),
      );

      currentIndex = searchIndex + originalQueryLength;
    }

    // Add remaining text
    if (currentIndex < widget.codes.length) {
      spans.add(
        TextSpan(
          text: widget.codes.substring(currentIndex),
          style: codeStyle,
        ),
      );
    }

    return Text.rich(TextSpan(children: spans));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onInverseSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Text(widget.name),
              ),
              const Spacer(),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  textStyle: const TextStyle(fontWeight: FontWeight.normal),
                ),
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: widget.codes),
                  ).then((value) {
                    setState(() {
                      _copied = true;
                    });
                  });
                  await Future.delayed(const Duration(seconds: 2));
                  setState(() {
                    _copied = false;
                  });
                },
                icon: Icon(
                  (_copied) ? Icons.done : Icons.content_paste,
                  size: 15,
                ),
                label: Text((_copied) ? "Copied!" : "Copy code"),
              ),
            ],
          ),
          const Divider(height: 1),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: _buildCodeText(),
          ),
        ],
      ),
    );
  }
}
