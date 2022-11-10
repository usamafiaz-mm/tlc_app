import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget(
      {Key? key, required this.latController, required this.longController})
      : super(key: key);
  final FormControl latController, longController;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool loader = false;
  bool touched = false;

  @override
  void initState() {
    widget.latController.touchChanges.listen((event) {
      setState(() {
        touched = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.4, 50)),
            onPressed: () async {
              Location location = Location();

              bool serviceEnabled;
              PermissionStatus permissionGranted;
              LocationData locationData;

              serviceEnabled = await location.serviceEnabled();
              if (!serviceEnabled) {
                serviceEnabled = await location.requestService();
                if (!serviceEnabled) {
                  return;
                }
              }

              permissionGranted = await location.hasPermission();
              if (permissionGranted == PermissionStatus.denied) {
                permissionGranted = await location.requestPermission();
                if (permissionGranted != PermissionStatus.granted) {
                  return;
                }
              }
              setState(() {
                loader = true;
              });
              locationData = await location.getLocation();
              widget.longController.updateValue(locationData.longitude);
              widget.latController.updateValue(locationData.latitude);

              setState(() {
                loader = false;
              });
            },
            child: loader
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text("Get Location")),
        if (widget.latController.value == null &&
            widget.longController.value == null &&
            touched)
          const Text(
            "Please Enter Location",
            style: TextStyle(color: Colors.red),
          )
      ],
    );
  }
}
