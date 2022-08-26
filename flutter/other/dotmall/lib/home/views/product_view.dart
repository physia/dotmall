import 'dart:async';
import 'dart:ui';

import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';

import '../../app/bloc/app_bloc.dart';
import '../../core/widgets/collection_widgets.dart';
import '../../core/widgets/elements.dart';
import '../../core/widgets/widgets.dart';
import '../widgets/widgets.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ScrollableArea(
        child: Column(
          children: [
            Container(
              padding: AppScaffold.edgeInsets,
              child: CollectionFindPanel<Products, Product>(
                id: RouteData.of(context).pathParameters["id"]!,
                collection: Products(Manager(context.read<AppBloc>().configs)),
                handlers: CollectionEventHandlers(),
                itemBuilder: (context, panel, model, state) {
                  return Column(
                    children: [
                      ScrollableArea(
                        direction: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            children: [
                              if (model != null)
                                for (var photo in model.photos)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                              Configs().makeUrl(photo.path)),
                                        ),
                                      ),
                                    ),
                                  )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  model?.name ?? "",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                CGradientBox(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(FluentIcons.heart_24_filled),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),

                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(children: [
                                  Icon(
                                    FluentIcons.star_24_regular,
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .color,
                                  ),
                                  Text(
                                    "4.5",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    "RATE",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ]),
                                Column(children: [
                                  Icon(
                                    FluentIcons.box_arrow_left_24_regular,
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .color,
                                  ),
                                  Text(
                                    "57",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    "ORDERS",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ]),
                                Column(children: [
                                  Icon(
                                    FluentIcons.person_24_regular,
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .color,
                                  ),
                                  Text(
                                    "4.5",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    "VIEWS",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ]),
                              ],
                            ),
                            // in stock
                            Text(
                              "In stock ${model?.quantity}",
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    Theme.of(context).textTheme.caption!.color,
                              ),
                              textAlign: TextAlign.start,
                            ),

                            // SizedBox(height: 12),
                            // price
                            Chip(
                              avatar: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              label: Text(
                                "${model?.price.toString() ?? ""}\$",
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              model?.description ?? "",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w100,
                                color:
                                    Theme.of(context).textTheme.caption!.color,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
