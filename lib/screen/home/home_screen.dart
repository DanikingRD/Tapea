import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tapea/constants.dart';
import 'package:tapea/provider/profile_notifier.dart';
import 'package:tapea/provider/user_notifier.dart';
import 'package:tapea/screen/home/components/home_layout.dart';
import 'package:tapea/screen/home/profile_screen.dart';
import 'package:tapea/screen/home/share_profile_screen.dart';
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
  bool _loading = false;
  late final Future<void> user;
  late final Future<void> profile;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<IconData> items = [
      FontAwesomeIcons.user,
      FontAwesomeIcons.addressBook,
      FontAwesomeIcons.qrcode,
    ];
    return HomeLayout(
      body: getBody(),
      footer: getFooter(context, items),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: _selectedPage,
      children: [
        const ProfileScreen(),
        Text('dsa'),
        ShareProfileScreen(),
      ],
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
                      color: _selectedPage == index
                          ? kSelectedPageColor
                          : kRedColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (_selectedPage == index) ...{
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: kRedColor),
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
