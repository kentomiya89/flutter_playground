# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Flutter Version

This project uses FVM (Flutter Version Manager) with Flutter 3.41.1 (stable). Prefix Flutter commands with `fvm` if FVM is installed:

```bash
fvm flutter run
fvm flutter build apk
fvm flutter pub get
```

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Build for release
flutter build apk          # Android
flutter build ios          # iOS
flutter build macos        # macOS

# Lint / analyze
flutter analyze

# Run tests (none currently exist)
flutter test
```

## Architecture

This is a single-file Flutter application (`lib/main.dart`) demonstrating QR code scanning with a custom overlay UI.

**Widget hierarchy:**

- `MyHome` (StatelessWidget) — entry point, renders `TestBarcodeScannerWithOverlay`
- `TestBarcodeScannerWithOverlay` (StatefulWidget) — owns `MobileScannerController`, defines the `scanWindow` Rect, composes scanner + overlay in a `Stack`
- `ScannedBarcodeLabel` (StatelessWidget) — listens to `controller.barcodes` stream via `StreamBuilder`, displays scanned values
- `ScanWindowOverlay` (StatelessWidget) — listens to controller state via `ValueListenableBuilder`, renders `ScanWindowPainter` only when scanner is initialized and running
- `ScanWindowPainter` (CustomPainter) — draws a semi-transparent overlay with a rectangular cutout over the scan window area

**Key package:** `mobile_scanner: ^6.0.6` — provides `MobileScannerController`, `MobileScanner` widget, `BarcodeCapture` stream, and `BarcodeFormat` enum.

**Platform requirements:** iOS 15.5+, Dart SDK 3.6.0+.
