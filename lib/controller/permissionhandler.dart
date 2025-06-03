import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission() async {
  var status = await Permission.storage.status;

  if (!status.isGranted) {
    var result = await Permission.storage.request();

    if (result.isGranted) {
      // Permission granted, proceed with your functionality
      print("Storage Permission Granted");
    } else if (result.isDenied) {
      // Permission denied
      print("Storage Permission Denied");
    } else if (result.isPermanentlyDenied) {
      // If permission is permanently denied, direct the user to the settings
      openAppSettings();
    }
  } else {
    // Already have permission
    print("Already have Storage Permission");
  }
}
 