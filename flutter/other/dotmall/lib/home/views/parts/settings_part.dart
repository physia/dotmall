import 'package:flutter/material.dart';

class SettingsPart extends StatelessWidget {
  const SettingsPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(30),
          child: Text("Soon...", style: Theme.of(context).textTheme.caption)),
    );
  }
}
