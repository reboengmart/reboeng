import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressMapper extends StatefulWidget {
  @override
  _AddAddressMapperState createState() => _AddAddressMapperState();
}

class _AddAddressMapperState extends State<AddAddressMapper> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;
  int _markerIdCounter = 0;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }


  _onMapCreated(GoogleMapController googleMapController){
    _controller.complete(googleMapController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Lokasi Anda'),),
      body: Stack(
        children: <Widget>[
          GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(-7.8757537, 111.4518134), zoom: 11.0),
            onMapCreated: _onMapCreated,
            mapType: _currentMapType,
            markers: Set<Marker>.of(_markers.values),
            myLocationButtonEnabled: true,
            onCameraMove: (CameraPosition position) {
              if(_markers.length > 0) {
                MarkerId markerId = MarkerId(_markerIdVal());
                Marker marker = _markers[markerId];
                Marker updatedMarker = marker.copyWith(
                  positionParam: position.target,
                );

                setState(() {
                  _markers[markerId] = updatedMarker;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
