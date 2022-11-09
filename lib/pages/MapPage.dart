import 'dart:async';

import 'package:apo_delivery/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  static const _initialCamaraPosition = CameraPosition(
    target: LatLng(18.502066, -69.8364374),
    zoom: 11.5,
  );

  late GoogleMapController _controller;

  Location location = Location();

  LatLng initMarker = const LatLng(0, 0);

  List<LatLng> polylineCoordinates = [];

  Marker marker = const Marker(
    markerId: MarkerId('Ordern'),
  );

  getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyADkL9jS0CmYS36Xp-i_MJKUFmFpxsrV_M',
      const PointLatLng(18.499886741236043, -69.84561863841931),
      const PointLatLng(18.500739692531766, -69.83935028775328),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }

  getGeoCode() async {
    final address = Provider.of<MainProvider>(context, listen: false)
        .getCurrentOrderAddress;

    try {
      List<geo.Location> locations = await geo.locationFromAddress(address);

      final latlng = locations.toList();

      marker = Marker(
        markerId: const MarkerId('Orden'),
        position: LatLng(latlng[0].latitude, latlng[0].longitude),
      );

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getGeoCode();
    getPolyPoints();
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      location.getLocation().then((value) {
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                value.latitude!,
                value.longitude!,
              ),
              zoom: 16,
            ),
          ),
        );
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    final main = Provider.of<MainProvider>(context);
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        mapType: MapType.hybrid,
        polylines: {
          Polyline(
            polylineId: const PolylineId('!'),
            points: polylineCoordinates,
            color: Colors.red,
            width: 3,
          ),
        },
        markers: {
          marker,
        },
        initialCameraPosition: _initialCamaraPosition,
        onMapCreated: (controller) {
          _controller = controller;
          getPolyPoints();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.center_focus_strong,
        ),
        onPressed: () async {
          getPolyPoints();
          location.getLocation().then((value) {
            _controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(
                    value.latitude!,
                    value.longitude!,
                  ),
                  zoom: 17,
                ),
              ),
            );
            setState(() {});
          });
        },
      ),
    );
  }
}
