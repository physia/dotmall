import 'dart:async';
import 'dart:ui';

import 'package:beamer/beamer.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bloc/app_bloc.dart';
import '../../app/view/app.dart';
import '../../core/widgets/collection_widgets.dart';
import '../widgets/widgets.dart';

class StoreView extends StatelessWidget {
  final String storeId;
  const StoreView({Key? key, required this.storeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsPanelController =
        StreamController<CollectionPanelEvent>.broadcast();
    return AppScaffold(
      body: ScrollableArea(
        onEnd: (metrics) async {
          productsPanelController.add(
            CollectionPanelLoadListEvent(
              ListRequestOptions(
                where: {
                  'store_id': storeId,
                },
              ),
            ),
          );
        },
        child: Padding(
          padding: AppScaffold.edgeInsets,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: CollectionFindPanel<Stores, Store>(
                  id: storeId,
                  collection: Stores(Manager(context.read<AppBloc>().configs)),
                  itemBuilder: (context, panel, model, state) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: AspectRatio(
                            aspectRatio: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: model == null
                                  ? SizedBox()
                                  : Image.network(
                                      Configs().makeUrl(panel.collection
                                          .semanticsOf(model!)
                                          .image
                                          .path),
                                      filterQuality: FilterQuality.none,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: AspectRatio(
                            aspectRatio: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: SizedBox.expand(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: SemanticCard(
                            model == null
                                ? null
                                : panel.collection.semanticsOf(model),
                            onPressed: null,
                            style: SemanticCardStyle(
                              direction: Axis.vertical,
                              decoration: BoxDecoration(),
                              leadingDecoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              leadingWidth: 100,
                              leadingHeight: 100,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              textAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                        ),
                      ],
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
                      model == null
                          ? null
                          : panel.collection.semanticsOf(model), onPressed: () {
                    context.beamToNamed("/products/${model!.id}");
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
      ),
    );
  }
}
