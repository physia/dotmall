import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bloc/app_bloc.dart';
import '../../app/view/app.dart';
import '../../category/widgets/widgets.dart';
import '../../core/widgets/collection_widgets.dart';
import '../../core/widgets/widgets.dart';
import '../../l10n/l10n.dart';
import '../widgets/widgets.dart';

class CategoryView extends StatelessWidget {
  final String categoryId;
  const CategoryView({Key? key, required this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storesPanelController =
        StreamController<CollectionPanelEvent>.broadcast();
    return AppScaffold(
      body: ScrollableArea(
        onEnd: (metrics) async {
          storesPanelController.add(
            CollectionPanelLoadListEvent(
              ListRequestOptions(
                where: {
                  'category_id': categoryId,
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
                child: CollectionFindPanel<Categories, Category>(
                  id: categoryId,
                  collection:
                      Categories(Manager(context.read<AppBloc>().configs)),
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
                          leadingWidth: 60,
                          leadingHeight: 60,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          textAlignment: CrossAxisAlignment.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
              CollectionListPanel<Stores, Store>(
                controller: storesPanelController,
                collection: Stores(Manager(context.read<AppBloc>().configs)),
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
                  return SizedBox(
                    width: 170,
                    child: SemanticCard(
                      model == null
                          ? null
                          : panel.collection.semanticsOf(model),
                      onPressed: () {
                        context.beamToNamed("/stores/${model!.id}");
                      },
                      style: SemanticCardStyle(
                        direction: Axis.vertical,
                        leadingWidth: 60,
                        leadingHeight: 60,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  );
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
