
import 'package:flutter/material.dart';

import '../../data/models/home/app_bar_item.dart';
import 'app_paths.dart';

List<AppNavigationItem> appBarItems = [
  AppNavigationItem(titre: AppPageTitle.dashboard,icon: Icons.dashboard_outlined,route: AppPaths.dashboard),
  AppNavigationItem(titre: AppPageTitle.rapports,icon: Icons.assignment_outlined,route: AppPaths.rapports),
  AppNavigationItem(titre: AppPageTitle.reglages,icon: Icons.settings_outlined,route: AppPaths.reglages),
];

abstract class AppPageTitle {
  static const dashboard = 'Dashboard';
  static const rapports = 'Rapports';
  static const reglages = 'Réglages';
}