
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'common/bloc/auth/auth_state_cubit.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_navigation_items.dart';
import 'core/router/app_router.dart';
import 'common/bloc/auth/auth_state.dart';
import 'presentation/home/bloc/user_infos_state.dart';
import 'presentation/home/bloc/user_infos_state_cubit.dart';
import 'service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'OBI',
      routerConfig: appRouter,
    );
  }
}

class AppContainer extends StatefulWidget {
  const AppContainer({super.key, required this.child});
  final Widget child;

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  var _currentIndex = 0;
  String pageName = 'OBI';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      //appBar: _buildAppBar(),
      body: widget.child,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );

  }

  SalomonBottomBar _buildBottomNavigationBar(BuildContext context) {
    return SalomonBottomBar(
        backgroundColor: AppColors.primary,
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _onItemTapped(i, context);
            _currentIndex = i;
          });
        },
        items: _appBarItems()
    );
  }

  List<SalomonBottomBarItem> _appBarItems(){
    return appBarItems.map((e){
      return SalomonBottomBarItem(
          icon: Icon(e.icon),
          title: Text(e.titre),
          selectedColor: Colors.white,
          unselectedColor: Colors.white);
    }).toList();
  }

  void _onItemTapped(int index, BuildContext context) {
    pageName = appBarItems[index].titre;
    GoRouter.of(context).go(appBarItems[index].route);
  }
  


  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(
        pageName,
        style: const TextStyle(color: Colors.white),
      ),
      leading: Builder(builder: (context) {
        return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ));
      }),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             _drawerHeader(),
            ListTile(
              title: const Text('Changer mot de passe'),
              leading: const Icon(
                Icons.lock_outline,
                color: AppColors.primary,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Assistance'),
              leading: const Icon(
                Icons.help_outline,
                color: AppColors.primary,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text("Conditions d'utilisation"),
              leading: const Icon(
                Icons.receipt_outlined,
                color: AppColors.primary,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text("Partager l'app"),
              leading: const Icon(
                Icons.share_outlined,
                color: AppColors.primary,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            const Divider(),
            BlocBuilder<AuthStateCubit,AuthState>(builder: (context,state){
              return ListTile(
                title: const Text(
                  'Déconnexion',
                  style: TextStyle(color: Colors.red),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onTap: () {
                  context.read<AuthStateCubit>().logout();
                  // ...
                },
              );
            }),
            const Divider(),
          ],
    )
    );
  }

  DrawerHeader _drawerHeader() {
    return DrawerHeader(
            child: SingleChildScrollView(
              child: BlocBuilder<UserInfosStateCubit,UserInfosState>(
                  builder: (context,state){
                    if(state is UserInfosSuccessState){
                      return Center(
                          child: Column(
                            children: [
                              const CircleAvatar(
                                minRadius: 30,
                                backgroundColor: AppColors.primary,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${state.user.prenom} ${state.user.nom}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.user.telephone),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.store,
                                    color: AppColors.primary,
                                  ),
                                  Text(state.user.boutique.nom),
                                ],
                              ),
                            ],
                          ));
                    }
                    return const Center();
                  }
              ),
            ),
          );
  }


}
