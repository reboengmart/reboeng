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
  List<Marker> _markers = [];
 static LatLng _lastMapPotition;
  MapType _currentMapType = MapType.normal;
  AddressNotifier addresProviderr;

  @override
  void initState(){
    super.initState();
  }
  _onMapCreated(GoogleMapController controller){
    setState(() {
      _controller.complete(controller);
    });

  }
  void _initLatlng(List<Address> address){
    GeoPoint _geo = address.first.geo;
    double lat = _geo.latitude;
    double lng = _geo.longitude;
    setState(() {
      _center = LatLng(lat, lng);
      _lastMapPotition = _center;
    });
    _markers=[];
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
    AddressApi().getLatlng(addressNotifier, widget.id);
    _initLatlng(addressNotifier.addressList);
    GeoPoint _geo = addressNotifier.addressList.first.geo;
    double lat = _geo.latitude;
    double lng = _geo.longitude;
    print('tessssssss ${lat.toString()} ${lng.toString()}');
    return Scaffold(
      appBar: AppBar(title: Text('Alamat Anda'),),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(lat,lng), zoom: 11.0),
            onMapCreated: _onMapCreated,
            mapType: _currentMapType,
            markers: Set.from(_markers),
            onCameraMove: _onCameraMove,
          ),
        ],
      ),
    );
  }
}
