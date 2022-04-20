import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapea/screen/home/components/home_layout_component.dart';
import 'package:tapea/util/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<IconData> items = [
      FontAwesomeIcons.user,
      FontAwesomeIcons.addressBook,
      FontAwesomeIcons.qrcode,
    ];
    return HomeLayoutComponent(
      body: Container(),
      footer: getFooter(context, items),
    );
  }

  Widget getFooter(BuildContext context, List<IconData> items) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        border: Border(
          top: BorderSide(width: 1, color: Colors.black.withOpacity(0.06)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            items.length,
            (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedPage = index;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      items[index],
                      size: 28,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (_selectedPage == index) ...{
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                    }
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
