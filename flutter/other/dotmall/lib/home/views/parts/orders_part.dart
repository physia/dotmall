import 'package:dotmall_sdk/dotmall_sdk.dart';
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
      scrollDirection: Axis.horizontal,
      scrollable: true,
      gridCount: 2,
      itemBuilder: (context, panel, model, state) {
        return SizedBox(
          width: 170,
          child: SemanticCard(
            model == null ? null : panel.collection.semanticsOf(model),
            onPressed: () {
              // App.router.push("/stores/${model!.id}");
            },
          ),
        );
      },
    );
  }
}
