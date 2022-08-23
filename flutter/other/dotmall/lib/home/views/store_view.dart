import 'dart:async';

import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

import '../../app/bloc/app_bloc.dart';
import '../../app/view/app.dart';
import '../../core/widgets/collection_widgets.dart';
import '../../core/widgets/widgets.dart';
import '../../l10n/l10n.dart';

class StoreView extends StatelessWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsPanelController =
        StreamController<CollectionPanelEvent>.broadcast();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 40,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(FluentIcons.arrow_left_48_regular),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          },
        ),
        // title: CGradientBox(child: AppLogo.square(30)),
        actions: [
          IconButton(
            icon: Icon(FluentIcons.cart_16_regular),
            onPressed: () {},
          ),
        ],
      ),
      body: ScrollableArea(
        onEnd: (metrics) async {
          productsPanelController.add(
            CollectionPanelLoadListEvent(
              ListRequestOptions(
                where: {
                  'store_id': RouteData.of(context).pathParameters['id']!,
                },
              ),
            ),
          );
        },
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CollectionFindPanel<Stores, Store>(
                id: RouteData.of(context).pathParameters["id"]!,
                collection: Stores(Manager(context.read<AppBloc>().configs)),
                handlers: CollectionEventHandlers(),
                itemBuilder: (context, panel, model, state) {
                  return SizedBox(
                    child: SemanticCard(
                      model == null
                          ? null
                          : panel.collection.semanticsOf(model),
                      onPressed: null,
                      style: SemanticCardStyle(
                        direction: Axis.vertical,
                        decoration: BoxDecoration(),
                        leadingWidth: 100,
                        leadingHeight: 100,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                  );
                },
              ),
            ),
            CollectionListPanel<Products, Product>(
              controller: productsPanelController,
              collection: Products(Manager(context.read<AppBloc>().configs)),
              handlers: CollectionEventHandlers(),
              scrollDirection: Axis.vertical,
              scrollable: false,
              autoStartLoad: false,
              gridCount: 2,
              onItemPressed: (List<Model> selections, model) {
                selections.clear();
                selections.add(model);
              },
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
    );
  }
}
