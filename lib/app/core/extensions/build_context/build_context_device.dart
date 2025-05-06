import 'dart:math';

import 'package:flutter/material.dart';

/// Extension on [BuildContext] to provide responsive design utilities and device information.
///
/// This extension provides convenient methods and getters for determining device characteristics,
/// screen sizes, and responsive breakpoints for Flutter applications.
extension DeviceContextExtension on BuildContext {
  /// Screen size breakpoints for different device categories
  static const double kMobileBreakpoint = 480.0;
  static const double kTabletBreakpoint = 768.0;
  static const double kDesktopBreakpoint = 1024.0;
  static const double kLargeDesktopBreakpoint = 1440.0;

  /// Returns the current [MediaQueryData] for this context.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the [Size] of the current media (e.g., the screen).
  Size get size => mediaQuery.size;

  /// Returns the width of the current media (e.g., the screen width).
  double get width => size.width;

  /// Returns the height of the current media (e.g., the screen height).
  double get height => size.height;

  /// Returns the device pixel ratio for the current media.
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Returns the [Orientation] of the current media (e.g., landscape or portrait).
  Orientation get orientation => mediaQuery.orientation;

  /// Returns `true` if the device is in landscape orientation.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Returns `true` if the device is in portrait orientation.
  bool get isPortrait => orientation == Orientation.portrait;

  /// Returns `true` if the screen width is considered a mobile device (<= `kMobileBreakpoint`).
  bool get isMobile => width <= kMobileBreakpoint;

  /// Returns `true` if the screen width is considered a tablet device (> `kMobileBreakpoint` and <= `kTabletBreakpoint`).
  bool get isTablet => width > kMobileBreakpoint && width <= kTabletBreakpoint;

  /// Returns `true` if the screen width is considered a desktop device (> `kTabletBreakpoint` and <= `kLargeDesktopBreakpoint`).
  bool get isDesktop =>
      width > kTabletBreakpoint && width <= kLargeDesktopBreakpoint;

  /// Returns `true` if the screen width is considered a large desktop device (> `kLargeDesktopBreakpoint`).
  bool get isLargeDesktop => width > kLargeDesktopBreakpoint;

  /// Returns the number of responsive columns based on the screen width.
  ///
  /// At least 1 column is always returned.
  ///
  /// Example:
  /// - If `width` is 1200 and `baseWidth` is 400, it returns 3.
  int responsiveColumns({double baseWidth = 400.0}) =>
      max((width / baseWidth).floor(), 1);

  /// Returns appropriate padding based on screen size.
  ///
  /// - Mobile: 8.0
  /// - Tablet: 24.0
  /// - Desktop: 32.0
  EdgeInsets get responsivePadding => EdgeInsets.all(
    isMobile
        ? 8.0
        : isTablet
        ? 24.0
        : 32.0,
  );

  /// Returns `true` if the device has a notch or similar display cutout.
  ///
  /// This is determined by checking if the top padding is greater than 20.
  bool get hasNotch => mediaQuery.padding.top > 20;

  /// Returns the top padding of the current media (e.g., the status bar height).
  double get paddingTop => mediaQuery.padding.top;

  /// Returns the bottom padding of the current media (e.g., navigation bar height).
  double get paddingBottom => mediaQuery.padding.bottom;

  /// Returns the height of the status bar.
  double get statusBarHeight => mediaQuery.padding.top;

  /// Returns the height of the on-screen keyboard.
  ///
  /// If the keyboard is hidden, this returns 0.
  double get keyboardHeight => mediaQuery.viewInsets.bottom;

  /// Returns `true` if the on-screen keyboard is currently visible.
  bool get isKeyboardVisible => mediaQuery.viewInsets.bottom > 0;

  /// Returns the safe area insets (top, bottom, left, right).
  ///
  /// Useful for layout calculations that need to avoid notches or system overlays.
  EdgeInsets get safeAreaInsets => mediaQuery.padding;
}
