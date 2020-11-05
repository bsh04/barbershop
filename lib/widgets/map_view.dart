import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMapView extends StatefulWidget {
  @override
  State<CustomMapView> createState() => CustomMapState();
}

class CustomMapState extends State<CustomMapView> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();

  int _markerIdCount = 1;

  bool _isMarker = false;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(55.347540, 86.158252),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(55.347540, 86.158252),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    _markers.add(
      Marker(
          markerId: MarkerId('marker'),
          position: LatLng(55.347540, 86.158252),
          infoWindow: InfoWindow(title: 'Не просто стрижка')),
    );

    return (GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      markers: _markers,
      scrollGesturesEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        controller.showMarkerInfoWindow(MarkerId('marker'));
      },
    ));
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
