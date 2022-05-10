import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tapea/screen/settings/components/option_divider.dart';

class AccountOption extends StatelessWidget {
  final String title;
  const AccountOption({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OptionDivider(),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                ),
                const Icon(Icons.arrow_forward)
              ],
            ),
          ),
        ),
        const OptionDivider(),
      ],
    );
  }
}
