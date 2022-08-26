import 'dart:ui';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../../app/app.dart';
import '../../core/widgets/collection_widgets.dart';
import '../../core/widgets/elements.dart';
import '../../core/widgets/gradient_box.dart';

class AppScaffold extends StatelessWidget {
  static var edgeInsets = const EdgeInsets.only(top: 61);

  const AppScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  final ScrollableArea body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.white,
              ),
              child: Container(
                // border on right
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.grey.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: ListView(
                  children: [
                    DrawerHeader(
                      child: Text("home"),
                    ),
                    ListTile(
                      title: Text("home"),
                      leading: Icon(FluentIcons.home_24_regular),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("category"),
                      leading: Icon(FluentIcons.box_24_regular),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("product"),
                      leading: Icon(FluentIcons.production_24_regular),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("order"),
                      leading: Icon(FluentIcons.re_order_24_regular),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("setting"),
                      leading: Icon(FluentIcons.settings_24_regular),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("about"),
                      leading: Icon(FluentIcons.chat_help_24_regular),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          body,
          Container(
            margin: const EdgeInsets.all(8),
            height: 45,
            child: Hero(
              tag: "APP_BAR_HERO_TAG",
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: AppBar(
                    backgroundColor:
                        Theme.of(context).canvasColor.withOpacity(0.7),
                    titleSpacing: 0,
                    leadingWidth: 40,
                    centerTitle: true,
                    leading: Builder(builder: (context) {
                      return Routemaster.of(context).history.canGoBack
                          ? IconButton(
                              icon: Icon(FluentIcons.arrow_left_24_regular),
                              onPressed: () {
                                Routemaster.of(context).pop();
                              },
                            )
                          : IconButton(
                              icon: Icon(FluentIcons.list_16_regular),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            );
                    }),
                    title: CGradientBox(
                      child: AppLogo.square(30),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(FluentIcons.cart_16_regular),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
