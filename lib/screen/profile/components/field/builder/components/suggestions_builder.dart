import 'package:flutter/widgets.dart';
import 'package:tapea/widget/suggestion_button.dart';

class SuggestionsBuilder extends StatelessWidget {
  final List<String> suggestions;
  final Function(String suggestion) onPressed;
  const SuggestionsBuilder({
    Key? key,
    required this.suggestions,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (suggestions.length <= 4) ...{
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                ...getSuggestions(),
              ],
            ),
          )
        }
      ],
    );
  }

  List<Widget> getSuggestions() {
    final List<SuggestionButton> buttons = [];
    for (int i = 0; i < suggestions.length; i++) {
      final String text = suggestions[i];
      buttons.add(
        SuggestionButton(
          suggestion: text,
          onPressed: () => onPressed(text),
        ),
      );
    }
    return buttons;
  }
}
