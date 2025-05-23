import 'package:web/web.dart' as web;
import 'dart:convert';

class ManifestServiceInternal {
  static init() {
    _setupInstallPromptListener();
  }

  static void _setupInstallPromptListener() {
    final head = web.document.head;
    if (head != null) {
      final link = web.document.createElement('link') as web.HTMLLinkElement;
      link.id = 'my-manifest-placeholder';
      link.rel = 'manifest';
      head.append(link);
    }

    // Create a JavaScript function for the event listener
    final script =
        web.document.createElement('script') as web.HTMLScriptElement;
    script.text = '''
      window.addEventListener('beforeinstallprompt', (event) => {
        event.preventDefault();
        window._hasInstallPrompt = true;
        window._deferredPrompt = event;
      });
    ''';
    web.document.head?.append(script);
    script.remove();
  }

  static showInstallPrompt() {
    final script =
        web.document.createElement('script') as web.HTMLScriptElement;
    script.text = '''
      if (window._hasInstallPrompt && window._deferredPrompt) {
        window._deferredPrompt.prompt();
      }
    ''';
    web.document.head?.append(script);
    script.remove();
  }

  static void setManifest(Map<String, dynamic> manifest) {
    final baseUrl = web.window.location.origin;

    // Create the manifest object directly in JavaScript
    final script =
        web.document.createElement('script') as web.HTMLScriptElement;
    script.text = '''
      function updateManifest(manifestData, baseUrl) {
        // Ensure icons have full URLs
        if (manifestData.icons) {
          manifestData.icons = manifestData.icons.map(icon => ({
            ...icon,
            src: baseUrl + "/" + icon.src
          }));
        }

        manifestData.start_url = baseUrl;

        const stringManifest = JSON.stringify(manifestData);
        const blob = new Blob([stringManifest], { type: 'application/json' });
        const manifestURL = URL.createObjectURL(blob);
        document.querySelector('#my-manifest-placeholder').setAttribute('href', manifestURL);
      }

      updateManifest(${jsonEncode(manifest)}, "$baseUrl");
    ''';
    web.document.head?.append(script);
    script.remove(); // Remove the script after execution
  }
}
