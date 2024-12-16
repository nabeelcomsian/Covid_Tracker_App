import 'package:covid_app/Models/worldStatesmodel.dart';
import 'package:covid_app/Services/World_States_Service.dart';
import 'package:covid_app/View/World_states_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatasScreen extends StatefulWidget {
  const WorldStatasScreen({super.key});

  @override
  State<WorldStatasScreen> createState() => _WorldStatasScreenState();
}

class _WorldStatasScreenState extends State<WorldStatasScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  // color code
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  WorldStatesService wordstates = WorldStatesService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 40, right: 10, bottom: 10),
        child: Column(
          children: [
            FutureBuilder<WorldStatesmodel>(
                future: wordstates.fetchWorldStates(),
                builder: (context, AsyncSnapshot<WorldStatesmodel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitCircle(
                        color: Colors.white,
                        controller: _controller,
                        size: 50.0,
                      ),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return Center(
                      child: Text('NO DATA FOUND PLEASE TRY AGAIN'),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total ':
                                double.parse(snapshot.data!.cases!.toString()),
                            'Recover': double.parse(
                                snapshot.data!.recovered!.toString()),
                            'Death':
                                double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                            legendTextStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18), // Set keys to white
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: Card(
                            color: const Color.fromARGB(255, 88, 85, 85),
                            child: Column(
                              children: [
                                ReuseableRow(
                                  title: "Total",
                                  vlaue: snapshot.data!.cases!.toString(),
                                ),
                                ReuseableRow(
                                  title: "Recover",
                                  vlaue: snapshot.data!.recovered!.toString(),
                                ),
                                ReuseableRow(
                                  title: "Death",
                                  vlaue: snapshot.data!.deaths!.toString(),
                                ),
                                ReuseableRow(
                                  title: "Active",
                                  vlaue: snapshot.data!.active!.toString(),
                                ),
                                ReuseableRow(
                                  title: "Critical",
                                  vlaue: snapshot.data!.critical!.toString(),
                                ),
                                ReuseableRow(
                                  title: "Today Deaths",
                                  vlaue: snapshot.data!.todayDeaths!.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const WorldStatesList();
                              }));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff1aa260),
                              ),
                              child: Center(child: Text("Track Country")),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class ReuseableRow extends StatelessWidget {
  ReuseableRow({super.key, required this.title, required this.vlaue});
  String? title, vlaue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '$title',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$vlaue',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
