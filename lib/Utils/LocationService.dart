import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    return status.isGranted;
  }

  Future<Position> getCurrentLocation() async {
    if (!await requestLocationPermission()) {
      throw Exception('Location permission not granted');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
