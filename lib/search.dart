import 'package:flutter/material.dart';
import 'routeDetails.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static List<Routes> mainRoutesList = [
    Routes("Ring Road", ["1234", "1235"], ["Kalanki", "Balkhu", "Koteshwor"],
        "15", "2:05"),
    Routes("Right - Left", ["2234", "2235"], ["KTM", "Hetauda", "Lalitpur"],
        "85", "3:15"),
    Routes("Hetauda - KTM", ["2234", "2235"], ["KTM", "Hetauda", "Lalitpur"],
        "85", "3:15")
  ];

  List<Routes> displayList = List.from(mainRoutesList);
  void updateListByTitle(String value) {
    setState(() {
      displayList = mainRoutesList
          .where((element) =>
              element.Title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void updateListByStop(String value) {
    if (value == '') {
      setState(() {
        displayList = mainRoutesList;
      });
    } else {
      setState(() {
        displayList = mainRoutesList.where((element) {
          List<String>? stops = element.Stops;
          for (var busStops in stops!) {
            if (busStops.toLowerCase().contains(value.toLowerCase())) {
              return true;
            }
          }
          return false;
        }).toList();

        if (displayList.length == 0) {
          updateListByTitle(value);
        }
        ;
      });
    }
  }

  void updateList(String value) {
    try {
      int No = int.parse(value);
      setState(() {
        displayList = [];
        displayList.add(mainRoutesList[No - 1]);
      });
    } catch (e) {
      updateListByStop(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => updateList(value),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search bus stops...",
                suffixIcon: Icon(Icons.search),
                suffixIconColor: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: displayList.length,
                itemBuilder: (context, index) => ListTile(
                  title: GestureDetector(
                    onTap: () =>
                        print('Route ${displayList[index].RouteNo} tapped'),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      padding: EdgeInsets.fromLTRB(
                          9 * 1.5, 10 * 1.5, 28 * 1.5, 10 * 1.5),
                      decoration: BoxDecoration(
                        color: const Color(0xffd9d9d9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        //for route 1
                        children: [
                          Column(
                            //C1
                            children: [
                              Text(
                                'Route ${displayList[index].RouteNo}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Image.asset('route.png'),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          Column(
                            //C2
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  displayList[index].Title!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'From: ${displayList[index].Stops?.first}',
                                ),
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'To: ${displayList[index].Stops?.last}',
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          Column(
                            //C3
                            children: [
                              Spacer(),
                              Image.asset('bus.png'),
                              Text('12'),
                              Spacer(),
                              Image.asset('distance.png'),
                              Text('21.5'),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          Column(
                            //C4
                            children: [
                              Spacer(),
                              Image.asset('bus-stop.png'),
                              Text('12'),
                              Spacer(),
                              Image.asset('clock.png'),
                              Text('21.5'),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
