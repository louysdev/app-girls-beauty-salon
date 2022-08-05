import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddressMapController {

  BuildContext context;
  Function refresh;

  CameraPosition initialPosition = CameraPosition(
    target: LatLng(18.4805683, -69.9570446),
    zoom: 14
  );

  Completer<GoogleMapController> _mapController = Completer();

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }
}