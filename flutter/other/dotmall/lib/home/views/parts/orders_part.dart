import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/view/app.dart';
import '../../../core/widgets/collection_widgets.dart';
import '../../bloc/home_bloc.dart';

class OrdersPart extends StatelessWidget {
  const OrdersPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CollectionListPanel<Orders, Order>(
      collection: Orders(Manager(context.read<HomeBloc>().configs)),
      handlers: CollectionEventHandlers(),
      scrollable: false,
      gridCount: 1,
      itemBuilder: (context, panel, model, state) {
        return SizedBox(
          width: 170,
          child: SemanticCard(
            model == null ? null : panel.collection.semanticsOf(model),
            onPressed: () {
              // Routemaster.of(context).push("/stores/${model!.id}");
            },
            leadingBuilder: () => Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(FluentIcons.box_24_regular),
            ),
          ),
        );
      },
    );
  }
}
