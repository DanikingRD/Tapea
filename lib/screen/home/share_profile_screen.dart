import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tapea/model/card_model.dart';

class ShareProfileScreen extends StatelessWidget {
  final ProfileModel profile;

  const ShareProfileScreen({
    required this.profile,
  });

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
