import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:industria/app/providers.dart';
import 'package:industria/app/router.dart';

import '../core/themes/theme.dart';
import '../l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../presentation/bloc/localization/localization_bloc.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Providers(
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          return MaterialApp.router(
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate
            ],
            supportedLocales: L10n.supported,
            locale: state.locale,
            backButtonDispatcher: RootBackButtonDispatcher(),
            theme: AppTheme.themeData,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
