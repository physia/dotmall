import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class AccountPart extends StatelessWidget {
  const AccountPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.all(30),
      child: ElevatedButton(
          onPressed: () {
            context.beamToNamed("/auth");
          },
          child: Text("LOGE IN...")),
    ));
  }
}
