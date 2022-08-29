import 'dart:async';
import 'dart:ui';

import 'package:beamer/beamer.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bloc/app_bloc.dart';
import '../../core/widgets/collection_widgets.dart';
import '../../core/widgets/elements.dart';
import '../../core/widgets/widgets.dart';
import '../bloc/home_bloc.dart';
import '../widgets/widgets.dart';

class ProductView extends StatefulWidget {
  final String productId;
  const ProductView({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final productController = StreamController<CollectionPanelEvent>.broadcast();
  final productsController = StreamController<CollectionPanelEvent>.broadcast();

  final List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    subscriptions.forEach((e) => e.cancel());
    productController.close();
    productsController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _configs = context.read<AppBloc>().configs;
    return Scaffold(
      body: AppScaffold(
        body: ScrollableArea(
          child: Column(
            children: [
              Container(
                padding: AppScaffold.edgeInsets,
                child: CollectionFindPanel<Products, Product>(
                  controller: productController,
                  id: widget.productId,
                  collection:
                      Products(Manager(_configs)),
                  itemBuilder: (context, panel, model, state) {
                    return Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ScrollableArea(
                            direction: Axis.horizontal,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                children: [
                                  for (var photo in model?.photos ??
                                      [null, null, null, null])
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: DecoratedBox(
                                        // border 1 and rounded
                                        decoration: BoxDecoration(
                                          color: photo == null
                                              ? Colors.grey.withOpacity(0.1)
                                              : null,
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(
                                                photo == null ? 0 : 0.3),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: photo == null
                                                ? AspectRatio(
                                                    aspectRatio: 1.5,
                                                    child: Icon(
                                                      FluentIcons
                                                          .circle_image_20_regular,
                                                      size: 60,
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                    ))
                                                : Image.network(
                                                    Configs()
                                                        .makeUrl(photo.path),
                                                    height: double.infinity,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  model == null
                                      ? TextPlaceholder(
                                          width: 200,
                                          lines: 2,
                                        )
                                      : Text(
                                          model.name,
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
                              Row(
                                children: [
                                  Chip(
                                    side: BorderSide(
                                        color: (model == null
                                            ? Colors.transparent
                                            : Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.5)),
                                        width: 1),
                                    backgroundColor: (model == null
                                            ? Colors.grey
                                            : Theme.of(context).primaryColor)
                                        .withOpacity(0.2),
                                    avatar: Icon(FluentIcons.money_24_regular,
                                        color: (model == null
                                            ? Colors.grey
                                            : Theme.of(context).primaryColor)),
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                    label: model == null
                                        ? TextPlaceholder(
                                            width: 30,
                                          )
                                        : Text(
                                            "${model?.price.toString() ?? ""}\$",
                                          ),
                                  ),
                                  SizedBox(width: 10),
                                  model == null
                                      ? TextPlaceholder()
                                      : Text(
                                          "${model.quantity} left In stock ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .color,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(children: [
                                    Icon(
                                      FluentIcons.star_24_regular,
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .color,
                                    ),
                                    model == null
                                        ? TextPlaceholder(
                                            width: 40,
                                          )
                                        : Text(
                                            "4.5",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                    Text(
                                      "RATE",
                                      style:
                                          Theme.of(context).textTheme.caption,
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
                                    model == null
                                        ? TextPlaceholder(
                                            width: 40,
                                          )
                                        : Text(
                                            "57",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                    Text(
                                      "ORDERS",
                                      style:
                                          Theme.of(context).textTheme.caption,
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
                                    model == null
                                        ? TextPlaceholder(
                                            width: 40,
                                          )
                                        : Text(
                                            "4.5",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                    Text(
                                      "VIEWS",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ]),
                                ],
                              ),
                              // SizedBox(height: 6),
                              Divider(height: 30),
                              Text(
                                "description".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .color,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: model == null
                                    ? TextPlaceholder(
                                        lines: 3,
                                        width: 300,
                                      )
                                    : Text(
                                        model.description ?? "(no description)",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w100,
                                          color: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .color!
                                              .withOpacity(0.5),
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              CollectionListPanel<Products, Product>(
                controller: productsController,
                collection: Products(Manager(context.read<HomeBloc>().configs)),
                handlers: CollectionEventHandlers(),
                scrollDirection: Axis.vertical,
                scrollable: false,
                gridCount: 2,
                title: Text("Suggestions"),
                itemBuilder: (context, panel, model, state) {
                  return SemanticCard(
                      model == null
                          ? null
                          : panel.collection.semanticsOf(model), onPressed: () {
                        //widget.productId
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<CollectionPanelEvent>(
            stream: productController.stream,
            builder: (context, snapshot) {
              Product? product;
              if (snapshot.data is CollectionPanelLoadedFindEvent<Product>) {
                product =
                    (snapshot.data as CollectionPanelLoadedFindEvent<Product>)
                        .model;
              }
              return Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text("ADD TO CARD"),
                      onPressed: product == null ? null : () {},
                    ),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                      onPressed: () {},
                      child: Icon(FluentIcons.bookmark_24_regular))
                ],
              );
            }),
      ),
    );
  }
}
