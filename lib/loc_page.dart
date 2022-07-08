import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationRoute extends StatefulWidget {
  const LocationRoute({Key? key}) : super(key: key);

  @override
  LocationRouteState createState() => LocationRouteState();
}

class LocationRouteState extends State<LocationRoute> {
  late Future<List<Placemark>> currentLocation;
  late Position coordinates;
  @override
  void initState() {
    super.initState();
    currentLocation = _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Current Location"),
      ),
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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ADDRESS:\n $locality"),
                        Text(
                            "COORDINATES:\n ${coordinates.latitude} ${coordinates.longitude}"),
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

    coordinates = await getLocation();

    return await placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude);
  }
}
