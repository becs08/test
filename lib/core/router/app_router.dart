import 'package:obi/common/bloc/button/button_state_cubit.dart';
import 'package:obi/core/constants/app_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:obi/main.dart';
import 'package:obi/presentation/rapports/pages/rapports_page.dart';
import 'package:obi/presentation/reglages/pages/reglages_page.dart';

import '../../common/bloc/auth/auth_state.dart';
import '../../common/bloc/auth/auth_state_cubit.dart';
import '../../presentation/auth/login/pages/login_page.dart';
import '../../presentation/Loading/page/loading_page.dart';
import '../../presentation/home/bloc/user_infos_state_cubit.dart';
import '../../presentation/home/pages/home_page.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppPaths.loading, // Commence par la LoadingPage
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => ButtonStateCubit()),
            BlocProvider<AuthStateCubit>(
              create: (BuildContext context) => AuthStateCubit()..appStarted(),
              lazy: false,
            ),
            BlocProvider<UserInfosStateCubit>(
              create: (BuildContext context) => UserInfosStateCubit(),
              lazy: false,
            ),
          ],
          child: BlocListener<AuthStateCubit, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticatedState) {
              GoRouter.of(context).go(AppPaths.login);
              } else if (state is AuthenticatedState) {
               GoRouter.of(context).go(AppPaths.dashboard);
              }
            },
            child: state.fullPath!.contains("main") ? child : AppContainer(child: child),
          ),
        );
      },
      routes: <RouteBase>[
        // Route vers LoadingPage
        GoRoute(
          path: AppPaths.loading,
          builder: (BuildContext context, GoRouterState state) {
            return LoadingPage(); // Affiche la page de chargement en premier
          },
        ),
        // Route vers LoginPage
        GoRoute(
          path: AppPaths.login,
          builder: (BuildContext context, GoRouterState state) {
            return LoginPage();
          },
        ),
        // Route vers HomePage
        GoRoute(
          path: AppPaths.dashboard,
          builder: (BuildContext context, GoRouterState state) {
            return HomePage();
          },
          routes: const <RouteBase>[],
        ),
        // Autres routes
        GoRoute(
          path: AppPaths.rapports,
          builder: (BuildContext context, GoRouterState state) {
            return RapportsPage();
          },
        ),
        GoRoute(
          path: AppPaths.reglages,
          builder: (BuildContext context, GoRouterState state) {
            return ReglagesPage();
          },
        )
      ],
    ),
  ],
);
