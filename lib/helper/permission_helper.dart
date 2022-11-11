import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestStoragePermissions() async {
    final List<Permission> permissionStatuses = [
      Permission.manageExternalStorage,
      Permission.storage,
    ];
    if (await checkStatuses(permissionStatuses)) {
      return true;
    } else {
      for (var permission in permissionStatuses) {
        await permission.request();
      }
      if (await checkStatuses(permissionStatuses)) {
        return true;
      } else {
        return false;
      }
    }
  }

  static Future<bool> checkStatuses(List<Permission> permissionStatuses) async {
    var statuses = await permissionStatuses.request();
    bool areAllGranted = true;
    statuses.forEach((key, value) {
      areAllGranted = areAllGranted && value == PermissionStatus.granted;
    });

    return areAllGranted;
  }
}
