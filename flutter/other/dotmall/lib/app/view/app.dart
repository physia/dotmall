// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../category/bloc/category_bloc.dart';
import '../../core/widgets/gradient_box.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/views/category_view.dart';
import '../../home/views/home_view.dart';
import '../../home/views/product_view.dart';
import '../../home/views/store_view.dart';
import '../../l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:beamer/beamer.dart';
import '../../auth/view/auth_view.dart';
import '../bloc/app_bloc.dart';

class App extends StatelessWidget {
  App({super.key});
  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => HomeView(),
        '/auth': (context, state, data) => AuthView(),
        '/categories/:id': (context, state, data) =>
            CategoryView(categoryId: state.pathParameters['id']!),
        '/stores/:id': (context, state, data) =>
            StoreView(storeId: state.pathParameters['id']!),
        '/products/:id': (context, state, data) =>
            ProductView(productId: state.pathParameters['id']!),
      },
    ),
  );
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (_) => AppBloc(
            configs: Configs(
              devEndpoint: "http://app.anibalco.com/api/v1",
              prodEndpoint: "http://app.anibalco.com/api/v1",
            ),
          ),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(AuthLoadingCacheEvent()),
        ),
        // HomeBloc
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        BlocProvider<CategoryBloc>(
          create: (_) => CategoryBloc(),
        ),
      ],
      child: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is AppConfigsUpdatedEvent) {
            context.read<CategoryBloc>().add(CategoryUpdateConfigsEvent(
                (state as AppConfigsUpdatedEvent).configs));
            context.read<HomeBloc>().add(HomeUpdateConfigsEvent(
                (state as AppConfigsUpdatedEvent).configs));
          }
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            drawerTheme: DrawerThemeData(
              backgroundColor: Colors.white30,
              elevation: 0,
              scrimColor: Colors.white.withOpacity(0.5),
            ),
            appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              titleTextStyle: TextStyle(),
              toolbarTextStyle: TextStyle(),
              iconTheme: IconThemeData(),
            ),
            primarySwatch:
                MaterialColor(CGradientBox.gradient.colors.last.value, {
              50: Color.fromARGB(255, 255, 255, 255),
              100: Color.fromARGB(255, 255, 255, 255),
              200: Color.fromARGB(255, 255, 255, 255),
              300: Color.fromARGB(255, 255, 255, 255),
              400: Color.fromARGB(255, 255, 255, 255),
              500: Color.fromARGB(255, 255, 255, 255),
              600: Color.fromARGB(255, 255, 255, 255),
              700: Color.fromARGB(255, 255, 255, 255),
              800: Color.fromARGB(255, 255, 255, 255),
              900: Color.fromARGB(255, 255, 255, 255),
            }),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                minimumSize: const Size(0, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shadowColor: CGradientBox.gradient.colors.last.withOpacity(0.4),
                elevation: 3,
                onPrimary: Colors.white,
                minimumSize: const Size(0, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(),
            buttonBarTheme: const ButtonBarThemeData(
              buttonTextTheme: ButtonTextTheme.accent,
            ),
            buttonTheme: ButtonThemeData(
              height: 45,
              buttonColor: CGradientBox.gradient.colors.last,
              textTheme: ButtonTextTheme.primary,
            ),
            textTheme: GoogleFonts.robotoTextTheme(
              Theme.of(context).textTheme.copyWith(
                    caption: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(height: 1.2),
                  ),
            ),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: AppLocalizations.supportedLocales[1],
          supportedLocales: AppLocalizations.supportedLocales,
          routerDelegate: routerDelegate,
          routeInformationParser: BeamerParser(),
        ),
      ),
    );
  }
}
