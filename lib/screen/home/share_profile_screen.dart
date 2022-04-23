import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tapea/model/card_model.dart';
import 'package:tapea/provider/profile_notifier.dart';

class ShareProfileScreen extends StatefulWidget {
  ShareProfileScreen();

  @override
  State<ShareProfileScreen> createState() => _ShareProfileScreenState();
}

class _ShareProfileScreenState extends State<ShareProfileScreen> {
  late final ProfileModel profile;

  @override
  void initState() {
    super.initState();
    profile = context.read<ProfileNotifier>().profile;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          QrImage(
            data: profile.title,
            size: 200,
          )
        ],
      ),
    );
  }
}
