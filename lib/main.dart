// ZIP Code Map App (Mock Implementation)
//
// This Flutter application provides a mock implementation for demonstration purposes, showcasing
// the potential functionality for real-world scenarios. Currently, it utilizes hardcoded ZIP code
// boundaries and OpenStreetMap tiles for visualization on the map. However, this implementation can
// be easily replaced with dynamic data fetching from APIs to obtain accurate ZIP code coordinates
// and boundary information. Additionally, future enhancements could include features such as entering
// a ZIP code to automatically fetch and display the corresponding area, thereby providing a more
// interactive and dynamic user experience.
//
// Features:
// - Display a map interface with selectable ZIP codes
// - Users can choose a ZIP code from a dropdown menu
// - Selected ZIP code boundaries are displayed on the map
// - Ability for users to draw polygons on the map to define custom areas of interest
// by tapping anywhere on the map
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZIP Code Map App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String selectedZipCode = "94102"; // Default ZIP code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ZIP Code Map'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedZipCode,
            onChanged: (String? newValue) {
              setState(() {
                selectedZipCode = newValue!;
              });
            },
            items: <String>['94102', '94103', '94104', '94105'] // Example ZIP codes
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text('ZIP Code: $value'),
              );
            }).toList(),
          ),
          Expanded(
            child: MapWidget(selectedZipCode: selectedZipCode),
          ),
        ],
      ),
    );
  }
}

class MapWidget extends StatefulWidget {
  final String selectedZipCode;

  MapWidget({required this.selectedZipCode});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  final MapController mapController = MapController();
  List<LatLng> points = [];
  @override
  Widget build(BuildContext context) {
    List<Polygon> polygons = []; // List to hold polygons of selected ZIP code

    // Logic to fetch polygons of the selected ZIP code
    if (widget.selectedZipCode == "94102") { // Example ZIP code (San Francisco, CA)
      polygons.add(
        Polygon(
          points: [
            LatLng(37.7749, -122.4194),
            LatLng(37.7749, -122.4312),
            LatLng(37.7816, -122.4312),
            LatLng(37.7816, -122.4194),
          ],
          color: Colors.blue.withOpacity(0.5), // Set boundary color
          borderColor: Colors.blue, // Set border color
          borderStrokeWidth: 2, // Set border width
        ),
      );
    }
     if  (widget.selectedZipCode == "94103"){
 polygons.add(
        Polygon(
          points: [
            LatLng(37.7749, -122.4194),
            LatLng(37.7649, -122.4312),
            LatLng(37.7816, -122.4312),
            LatLng(37.7816, -122.4194),
          ],
          color: Colors.blue.withOpacity(0.5), // Set boundary color
          borderColor: Colors.blue, // Set border color
          borderStrokeWidth: 2, // Set border width
        ),
      );

    }


    return FlutterMap(
      options: MapOptions(
        center: LatLng(37.7749, -122.4194), // Default center coordinates
        zoom: 13.0, // Default zoom level
        onTap: _handleTap,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        PolygonLayer(
          polygons: polygons, // Display selected ZIP code's boundaries
        ),
         PolygonLayer(
            polygons: [
              Polygon(
                points: points,
                color: Colors.green.withOpacity(0.5),
                borderColor: Colors.green,
                borderStrokeWidth: 2,
              ),
            ],
          ),
      ],
    );
  }
   void _handleTap(TapPosition tapPosition, LatLng latLng) {
  setState(() {
    points.add(latLng);
  });
}
}
