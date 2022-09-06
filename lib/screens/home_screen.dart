import 'package:flutter/material.dart';
import 'package:paper_clip/model/overview.dart';
import 'package:paper_clip/model/performance.dart';
import 'package:paper_clip/services/get_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Overview> _overviews = <Overview>[];

  @override
  void initState() {
    super.initState();
    // getData();
    debugPrint("snapshot.data.toString()");
  }

  // getData() async {
  //   List<Overview> overviews = await GetData.fetchOverview();
  //   if (overviews != null) {
  //     setState(() {
  //       _overviews = overviews;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Paper Clip")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Overview",
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(height: 2, color: Colors.grey),
              FutureBuilder<Map<String, dynamic>>(
                  future: GetData.fetchOverview(),
                  builder: (context, snapshot) {
                    var overviews = snapshot.data;
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: overviews!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(overviews.keys.elementAt(index)),
                                    Text((overviews.values.elementAt(index) ??
                                            "No Data")
                                        .toString()),
                                  ],
                                ),
                              );
                            }),
                      );
                    } else if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(snapshot.error.toString())));
                    }
                    return const CircularProgressIndicator(
                      color: Colors.blueGrey,
                    );
                  }),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Performance",
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 5),
              const Divider(height: 2, color: Colors.grey),
              FutureBuilder<List<Performance>>(
                future: GetData.fetchPerformance(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Text("No Data");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.blueGrey,
                    );
                  } else if (snapshot.hasData) {
                    List<Performance> performances =
                        (snapshot.data as List<Performance>);
                    return Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: performances.length,
                          itemBuilder: (context, index) {
                            Performance performance = performances[index];
                            double percent =
                                performance.changePercent.toPrecision(2);
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 10),
                              child: Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(performance.label),
                                    SizedBox(
                                        height: 10,
                                        width: 70,
                                        child: Progress(percent: percent)),
                                    Text(
                                      percent.toString(),
                                      style: TextStyle(
                                          color: percent > 0
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  return const Center(
                    child: Text("No Performance data"),
                  );
                },
              )
            ],
          ),
        ));
  }
}

class Progress extends StatelessWidget {
  const Progress({
    Key? key,
    required this.percent,
  }) : super(key: key);

  final double percent;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: percent,
      // semanticsValue: ,
      minHeight: 5,
      backgroundColor: Colors.grey[300],
      color: percent < 0 ? Colors.red : Colors.green,
    );
  }
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
