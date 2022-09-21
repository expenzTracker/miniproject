import 'dart:async';

import 'package:first_app/classes/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'components/navbar.dart';
import 'drawer_component.dart';

class LocationRoute extends StatefulWidget {
  const LocationRoute({Key? key}) : super(key: key);

  @override
  LocationRouteState createState() => LocationRouteState();
}

class LocationRouteState extends State<LocationRoute> {
  late Future<List<Placemark>> currentLocation;
  late double latitude;
  late double longitude;
  @override
  void initState() {
    super.initState();
    currentLocation = _determinePosition();
  }

  void changeCoordinates(double lat, double lng) {
    setState(() {
      latitude = lat;
      longitude = lng;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Current Location"),
        backgroundColor: ColorPalette.piggyViolet,
      ),
      bottomNavigationBar: const Navbar(),
      drawer: const DrawerComponent(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            currentLocation = _determinePosition();
          });
        },
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                future: currentLocation,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Placemark> position =
                        snapshot.data as List<Placemark>;
                    String locality = position[2].toString().substring(
                        position[0].toString().indexOf('Name:') + 5,
                        position[0].toString().indexOf('Country'));
                    String place =
                        'Government Engineering College Thrissur Kerala';
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ADDRESS:\n $locality"),
                        Text("\nCOORDINATES:\n $latitude , $longitude"),
                        Text("\nPLACE:\n $place")
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<List<Placemark>> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position coordinates = await getLocation();
    latitude = coordinates.latitude;
    longitude = coordinates.longitude;
    if (latitude.toString().contains('10.55') &&
        longitude.toString().contains('76.22')) {}

    LocationSettings locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 50,
      foregroundNotificationConfig: ForegroundNotificationConfig(
        notificationText: "Latitude:$latitude Longitude:$longitude",
        notificationTitle: "Running in Background...",
        enableWakeLock: true,
      ),
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      changeCoordinates(double.parse(position.latitude.toStringAsFixed(4)),
          double.parse(position.longitude.toStringAsFixed(4)));
    });

    // var googlePlace = gp.GooglePlace("AIzaSyALEXJPfi_Dfm9knUmNbPxuQEVUWRemqAQ");
    // var result = await googlePlace.details
    //     .get("ChIJN1t_tDeuEmsRUsoyG83frY4", fields: "name");

    // //print("*******RESULT********${result?.result}");

    return await placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude);
  }
}
