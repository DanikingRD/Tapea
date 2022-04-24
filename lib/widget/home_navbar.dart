import 'package:flutter/material.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/util/colors.dart';

class HomeBottomNavBar extends StatefulWidget {
  final List<IconData> icons;
  final ValueChanged<int>? onTap;
  final int currentIndex;

  const HomeBottomNavBar({
    required this.icons,
    required this.onTap,
    this.currentIndex = 0,
  });

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        border: Border(
          top: BorderSide(width: 1, color: Colors.black.withOpacity(0.06)),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 109, 107, 107),
            blurRadius: 1.5,
            offset: Offset(
              0.0,
              1.0,
            ),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.icons.length, (index) {
            final bool selected = widget.currentIndex == index;
            return InkWell(
              onTap: () {
                widget.onTap!(index);
              },
              child: Column(
                children: [
                  Icon(
                    widget.icons[index],
                    size: 28,
                    color: selected ? kSelectedPageColor : kRedColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (selected) ...{
                    getIndicator(),
                  }
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget getIndicator() {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: kRedColor,
      ),
    );
  }
}
