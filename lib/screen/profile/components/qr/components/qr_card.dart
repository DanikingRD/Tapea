import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QrCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onClick;
  const QrCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        color: Theme.of(context).inputDecorationTheme.fillColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(
                icon,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
