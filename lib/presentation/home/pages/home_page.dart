import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/auth/auth_state.dart';
import '../../../common/bloc/auth/auth_state_cubit.dart';
import '../../../core/constants/app_colors.dart';
import '../bloc/user_infos_state.dart';
import '../bloc/user_infos_state_cubit.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final shadowColor = const Color(0xFFCCCCCC);
  final dataList = [
    const _BarData(Color(0xFFF39221), 18,  'Lundi'),
    const _BarData(Color(0xFFF39221), 5,  'Mardi'),
    const _BarData(Color(0xFFF39221), 10,  'Mercredi'),
    const _BarData(Color(0xFFF39221), 28.5, 'Jeudi'),
    const _BarData(Color(0xFFF39221), 6, 'Vendredi'),
    const _BarData(Color(0xFFF39221), 10, 'Samedi'),
    const _BarData(Color(0xFFF39221), 10, 'Dimanche'),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 20,    //Taille des barres
            borderSide: const BorderSide(
            color: Color(0xFF232954),
            width: 2,
          )
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,  // Fond gris clair
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Row(
                children: [
                  InkWell(
                      child: const Icon(Icons.add_chart),
                    onTap: () => context.read<AuthStateCubit>().logout(),
                  ),
                  const Text('Dashboard',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF232954),
                    ),
                  ),
                ],
              ),
              // Section des cartes récapitulatives
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  childAspectRatio: 2.1, //hauteur des cartes
                  crossAxisCount: 2, // 2 colonnes
                  crossAxisSpacing: 8, // Espacement horizontal
                  mainAxisSpacing: 8, // Espacement vertical
                  shrinkWrap: true, // Permet à la grille de s'adapter au contenu
                  physics: const NeverScrollableScrollPhysics(), // Désactive le scroll dans la grille
                  children: List.generate(4, (index) {
                    return const Card(
                      color: Colors.white, // Couleur des cartes
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Montant des ventes",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                  color: Color(0xFF929292),
                              ),
                            ),
                            Text(
                              "89 000 FCFA",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF242B5A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Diagramme en barres
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white, // Carte en blanc
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      AspectRatio(
                        aspectRatio: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceBetween,
                              borderData: FlBorderData(
                                show: true,
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: AppColors.borderColor.withOpacity(0.2),
                                  ),
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                leftTitles: AxisTitles(
                                  drawBelowEverything: true,
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color(0xFF4F4F4F)
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 36,
                                    getTitlesWidget: (value, meta) {
                                      final index = value.toInt();
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Center(
                                          child: Text(
                                            widget.dataList[index].day.substring(0, 3),
                                            style: const TextStyle(
                                                color: Color(0xFF4F4F4F)
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                rightTitles: const AxisTitles(),
                                topTitles: const AxisTitles(),
                              ),
                              gridData: FlGridData(
                                show: true,
                                getDrawingHorizontalLine: (value) => const FlLine(
                                  color: Color(0xFFECECEC),
                                  strokeWidth: 2,
                                ),
                                getDrawingVerticalLine: (value) => const FlLine(
                                  color: Color(0xFFECECEC),
                                  strokeWidth: 2,
                                ),
                              ),
                              barGroups: widget.dataList.asMap().entries.map((e) {
                                final index = e.key;
                                final data = e.value;
                                return generateBarGroup(
                                  index,
                                  data.color,
                                  data.value,
                                );
                              }).toList(),
                              barTouchData: BarTouchData(
                                enabled: true,
                                handleBuiltInTouches: false,
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipColor: (group) => Colors.transparent,
                                  tooltipMargin: 0,
                                  getTooltipItem: (
                                      BarChartGroupData group,
                                      int groupIndex,
                                      BarChartRodData rod,
                                      int rodIndex,
                                      ) {
                                    return BarTooltipItem(
                                      rod.toY.toString(),
                                      TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: rod.color,
                                        fontSize: 18,
                                        shadows: const [
                                          Shadow(
                                            color: Colors.black26,
                                            blurRadius: 12,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                touchCallback: (event, response) {
                                  if (event.isInterestedForInteractions &&
                                      response != null &&
                                      response.spot != null) {
                                    setState(() {
                                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                                    });
                                  } else {
                                    setState(() {
                                      touchedGroupIndex = -1;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Diagramme circulaire
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white, // Carte en blanc
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            flex : 2,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: PieChart(
                                      PieChartData(
                                        pieTouchData: PieTouchData(
                                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                            setState(() {
                                              if (!event.isInterestedForInteractions ||
                                                  pieTouchResponse == null ||
                                                  pieTouchResponse.touchedSection == null) {
                                                touchedIndex = -1;
                                                return;
                                              }
                                              touchedIndex =
                                                  pieTouchResponse.touchedSection!.touchedSectionIndex;
                                            });
                                          },
                                        ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 30,
                                        sections: showingSections(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                              child: Container()),
                          const Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Indicator(
                                    color: Color(0xFFF39221),
                                    text: 'Produit 1',
                                    isRectangle: true,
                                    //size: 7,
                                  ),
                                  Indicator(
                                    color: Color(0xFF232954),
                                    text: 'Produit 2',
                                    isRectangle: true,
                                  ),
                                  Indicator(
                                    color: Color(0xFF7E848B),
                                    text: 'Produit 3',
                                    isRectangle: true,
                                  ),
                                  Indicator(
                                    color: Color(0xFFD6E5E5),
                                    text: 'Produit 4',
                                    isRectangle: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




//Format diagramme circulaire
  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 40.0 : 30.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFF232954),
            value: 25,
            title: '25%',
            showTitle: false,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFF7E848B),
            value: 25,
            showTitle: false,
            title: '25%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFFD6E5E5),
            value: 10,
            showTitle: false,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xFFF39221),
            value: 40,
            title: '40%',
            showTitle: false,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  //Menu Vertical

/* AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(
        'OBI',
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
  } */

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
        BlocBuilder<AuthStateCubit, AuthState>(builder: (context, state) {
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
    ));
  }

  DrawerHeader _drawerHeader() {
    return DrawerHeader(
      child: SingleChildScrollView(
        child: BlocBuilder<UserInfosStateCubit, UserInfosState>(
            builder: (context, state) {
          if (state is UserInfosSuccessState) {
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
        }),
      ),
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value,  this.day);
  final Color color;
  final double value;
  //final double shadowValue;
  final String day;
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isRectangle,
    this.size = 10,
    this.textColor = Colors.grey,
  });
  final Color color;
  final String text;
  final bool isRectangle;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: isRectangle ? size*3 : size,
          height: size,
          decoration: BoxDecoration(
            shape: isRectangle ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            //fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}


/*Scaffold(
      drawer: _buildDrawer(context),
      appBar: _buildAppBar(),
      body: widget.child,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );*/


/*
Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Text("Aujourd'hui"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${fmf.output.withoutFractionDigits} FCFA',
                            style: TextStyle(
                              fontSize: 35,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w400
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: 25,),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Indicator(
                                    color: Colors.green,
                                    text: 'Payée',
                                    isSquare: true,
                                  ),
                                  Text(
                                    '22093898 FCFA',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Indicator(
                                    color: Colors.red,
                                    text: 'Crédit',
                                    isSquare: true,
                                  ),
                                  Text(
                                    '22093898 FCFA',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: PieChart(
                                      PieChartData(
                                        pieTouchData: PieTouchData(
                                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                            setState(() {
                                              if (!event.isInterestedForInteractions ||
                                                  pieTouchResponse == null ||
                                                  pieTouchResponse.touchedSection == null) {
                                                touchedIndex = -1;
                                                return;
                                              }
                                              touchedIndex = pieTouchResponse
                                                  .touchedSection!.touchedSectionIndex;
                                            });
                                          },
                                        ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 40,
                                        sections: showingSections(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 2,),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24,right: 24,top: 18),
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceBetween,
                              borderData: FlBorderData(
                                show: true,
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: AppColors.borderColor.withOpacity(0.2),
                                  ),
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                leftTitles: AxisTitles(
                                  drawBelowEverything: true,
                                  sideTitles: SideTitles(
                                    showTitles: false,
                                    reservedSize: 30,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        textAlign: TextAlign.left,
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 36,
                                    getTitlesWidget: (value, meta) {
                                      final index = value.toInt();
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Center(child: Text(widget.dataList[index].day.substring(0,3))),
                                        /*
                                        child: _IconWidget(
                                          color: widget.dataList[index].color,
                                          isSelected: touchedGroupIndex == index,
                                        )
                                         */

                                      );
                                    },
                                  ),
                                ),
                                rightTitles: const AxisTitles(),
                                topTitles: const AxisTitles(),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                getDrawingHorizontalLine: (value) => FlLine(
                                  color: AppColors.borderColor.withOpacity(0.2),
                                  strokeWidth: 1,
                                ),
                              ),
                              barGroups: widget.dataList.asMap().entries.map((e) {
                                final index = e.key;
                                final data = e.value;
                                return generateBarGroup(
                                  index,
                                  data.color,
                                  data.value,
                                  data.shadowValue,
                                );
                              }).toList(),
                              //maxY: 20,
                              barTouchData: BarTouchData(
                                enabled: true,
                                handleBuiltInTouches: false,
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipColor: (group) => Colors.transparent,
                                  tooltipMargin: 0,
                                  getTooltipItem: (
                                      BarChartGroupData group,
                                      int groupIndex,
                                      BarChartRodData rod,
                                      int rodIndex,
                                      ) {
                                    return BarTooltipItem(
                                      rod.toY.toString(),
                                      TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: rod.color,
                                        fontSize: 18,
                                        shadows: const [
                                          Shadow(
                                            color: Colors.black26,
                                            blurRadius: 12,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                touchCallback: (event, response) {
                                  if (event.isInterestedForInteractions &&
                                      response != null &&
                                      response.spot != null) {
                                    setState(() {
                                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                                    });
                                  } else {
                                    setState(() {
                                      touchedGroupIndex = -1;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
 */
