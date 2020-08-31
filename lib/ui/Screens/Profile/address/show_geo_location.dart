import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/AddressNotifier.dart';
import 'package:reboeng/services/api/address_api.dart';
import 'package:reboeng/services/model/address.dart';



class ShowGeoLocation extends StatefulWidget {
  final String id;
  ShowGeoLocation(this.id);
  @override
  _ShowGeoLocationState createState() => _ShowGeoLocationState();
}

class _ShowGeoLocationState extends State<ShowGeoLocation> {


  Completer<GoogleMapController> _controller = Completer();
  static LatLng _center;
  final Set<Marker> _markers = {};
  LatLng _lastMapPotition;
  MapType _currentMapType = MapType.normal;

  @override
  void initState(){
    super.initState();
    AddressNotifier addressNotifier =
    Provider.of<AddressNotifier>(context, listen: false);
    AddressApi().getLatlng(addressNotifier, widget.id);
  }

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  void _initLatlng(List<Address> address){
    List addresss = List.generate(address.length, (index) => address[index].geo);
    GeoPoint _geo = addresss[0];
    double lat = _geo.latitude;
    double lng = _geo.longitude;

    _center = LatLng(lat, lng);
    _lastMapPotition = _center;
    _markers.add(
      Marker(
        markerId: MarkerId(_lastMapPotition.toString()),
        position: _lastMapPotition,
        infoWindow: InfoWindow(
          title: 'Ini Adalah alamat anda',
          snippet: '${lat.toString()} ${lng.toString()}'
        ),
        icon: BitmapDescriptor.defaultMarker,
      )
    );
  }

  _onCameraMove(CameraPosition position){
    _lastMapPotition = position.target;
  }


  @override
  Widget build(BuildContext context) {
    AddressNotifier addressNotifier = Provider.of<AddressNotifier>(context);
    _initLatlng(addressNotifier.addressList);
    return Scaffold(
      appBar: AppBar(title: Text('Alamat Anda'),),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 15.0),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
        ],
      ),
    );
  }
}
