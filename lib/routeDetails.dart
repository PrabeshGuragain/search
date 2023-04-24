// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

class Routes {
  static var counter = 1;
  int? RouteNo;
  String? Title;
  List<String>? BusId;
  List<String>? Stops;
  String? Distance;
  String? Time;

  Routes(this.Title, this.BusId, this.Stops, this.Distance, this.Time) {
    RouteNo = counter++; 
    // assign route number to route and increse the counter by 1 for next route
  }
}
