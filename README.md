# Dynamic PWA

A Flutter package that provides dynamic Progressive Web App (PWA) functionality, allowing you to programmatically manage your web app's manifest and installation prompts.

## Features

- Dynamic manifest management
- Programmatic control of PWA installation prompts
- Cross-platform support (web and non-web platforms)
- Automatic URL resolution for manifest assets

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  dynamic_pwa: ^1.0.0  # Use the latest version
```

## Setup

Before using this package, you need to remove the default manifest line from your Flutter web project's `web/index.html` file. Look for and remove this line:

```html
<link rel="manifest" href="manifest.json">
```

This is necessary because the package dynamically manages the manifest link element.

## Usage

### Initialize the Service

```dart
import 'package:dynamic_pwa/dynamic_pwa.dart';

void main() {
  ManifestService.init();
  // ... rest of your app initialization
}
```

### Set Dynamic Manifest

```dart
ManifestService.setManifest({
  'name': 'My PWA',
  'short_name': 'PWA',
  'description': 'My Progressive Web App',
  'icons': [
    {
      'src': 'icons/icon-192x192.png',
      'sizes': '192x192',
      'type': 'image/png'
    },
    {
      'src': 'icons/icon-512x512.png',
      'sizes': '512x512',
      'type': 'image/png'
    }
  ],
  'theme_color': '#FFFFFF',
  'background_color': '#FFFFFF',
  'display': 'standalone',
  'orientation': 'portrait'
});
```

### Show Install Prompt

```dart
// Call this when you want to show the PWA installation prompt
ManifestService.showInstallPrompt();
```

## Platform Support

- **Web**: Full support for manifest management and installation prompts
- **Non-web platforms**: Stub implementations that do nothing (safe to use in cross-platform apps)

## How it Works

The package uses conditional imports to provide different implementations for web and non-web platforms:

- On web platforms, it manages the web app manifest and installation prompts using JavaScript interop
- On non-web platforms, it provides stub implementations that do nothing

The manifest service automatically:
- Resolves relative URLs to absolute URLs using the current origin
- Handles the PWA installation prompt lifecycle
- Manages the manifest link element in the document head

## License

[Add your license here]

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
