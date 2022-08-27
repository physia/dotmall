import 'dart:async';

import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

import '../../app/app.dart';
import '../../category/widgets/widgets.dart';
import '../../core/widgets/collection_widgets.dart';
import '../bloc/home_bloc.dart';
import '../widgets/widgets.dart';
import 'parts/orders_part.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _bottomNavigationBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    final prooductsPanelController =
        StreamController<CollectionPanelEvent>.broadcast();
    var childs = <Widget>[
      ScrollableArea(
        arrows: ScrollableAreaArrows(
          bottom: true,
          top: false,
        ),
        onEnd: (metrics) async {
          prooductsPanelController.add(CollectionPanelLoadMoreEvent());
        },
        child: Column(
          children: [
            SizedBox(height: 45 + 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
              ),
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 5.5),
                  hintText: "Search for ?",
                  prefixIcon: Icon(FluentIcons.search_16_regular),
                  suffix: TextButton(
                    onPressed: () {},
                    child: Text("بحث"),
                  ),
                ),
              ),
            ),
            ScrollableArea(
              direction: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    for (var photo in [
                      "assets/images/i1.png",
                      "assets/images/i2.png",
                      "assets/images/i3.png"
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        child: DecoratedBox(
                          // border 1 and rounded
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                  height: 150, child: Image.asset(photo)),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            CollectionListPanel<Categories, Category>(
              collection: Categories(Manager(context.read<HomeBloc>().configs)),
              handlers: CollectionEventHandlers(),
              scrollDirection: Axis.horizontal,
              scrollable: true,
              gridCount: 1,
              itemBuilder: (context, panel, model, state) {
                return CategoryCard(
                    selected: false,
                    onPressed: model == null
                        ? null
                        : () {
                            Routemaster.of(context)
                                .push("/categories/${model.id}");
                          },
                    model: model);
              },
            ),
            CollectionListPanel<Stores, Store>(
              collection: Stores(Manager(context.read<HomeBloc>().configs)),
              handlers: CollectionEventHandlers(),
              scrollDirection: Axis.horizontal,
              scrollable: true,
              gridCount: 2,
              itemBuilder: (context, panel, model, state) {
                return SizedBox(
                  width: 170,
                  child: SemanticCard(
                    model == null ? null : panel.collection.semanticsOf(model),
                    onPressed: () {
                      App.router.push("/stores/${model!.id}");
                    },
                  ),
                );
              },
            ),
            CollectionListPanel<Products, Product>(
              controller: prooductsPanelController,
              collection: Products(Manager(context.read<HomeBloc>().configs)),
              handlers: CollectionEventHandlers(),
              scrollDirection: Axis.vertical,
              scrollable: false,
              gridCount: 2,
              itemBuilder: (context, panel, model, state) {
                return SemanticCard(
                    model == null ? null : panel.collection.semanticsOf(model),
                    onPressed: () {
                  App.router.push("/products/${model!.id}");
                },
                    style: SemanticCardStyle(
                      leadingAspectRatio: 1,
                      leadingWidth: double.infinity,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textAlignment: CrossAxisAlignment.center,
                      direction: Axis.vertical,
                    ),
                    suffix: IconButton(
                        onPressed: () {},
                        icon: Icon(FluentIcons.cart_24_regular)));
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      OrdersPart()
    ];
    return Scaffold(
      body: AppScaffold(body: childs.elementAt(_bottomNavigationBarIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavigationBarIndex,
        onTap: (value) {
          setState(() {
            _bottomNavigationBarIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _bottomNavigationBarIndex == 0
                ? const Icon(FluentIcons.home_24_filled)
                : const Icon(FluentIcons.home_24_regular),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _bottomNavigationBarIndex == 1
                ? const Icon(FluentIcons.box_24_filled)
                : const Icon(FluentIcons.box_24_regular),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: _bottomNavigationBarIndex == 2
                ? const Icon(FluentIcons.person_24_filled)
                : const Icon(FluentIcons.person_24_regular),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: _bottomNavigationBarIndex == 3
                ? const Icon(FluentIcons.settings_24_filled)
                : const Icon(FluentIcons.settings_24_regular),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
