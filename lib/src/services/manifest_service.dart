import 'manifest_service_stub.dart'
    if (dart.library.js) 'manifest_service_web.dart';

class ManifestService {
  static init() {
    ManifestServiceInternal.init();
  }

  static showInstallPrompt() {
    ManifestServiceInternal.showInstallPrompt();
  }

  static void setManifest(Map<String, dynamic> manifest) {
    ManifestServiceInternal.setManifest(manifest);
  }
}
