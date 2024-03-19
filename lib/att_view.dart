import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AttView extends StatefulWidget {
  const AttView({super.key});

  @override
  State<AttView> createState() => _AttViewState();
}

class _AttViewState extends State<AttView> {
  String _authStatus = 'Unknown';

  @override
  void initState() {
    super.initState();

    if (!kIsWeb && Platform.isIOS) {
      // It is safer to call native code using addPostFrameCallback after the widget has been fully built and initialized.
      // Directly calling native code from initState may result in errors due to the widget tree not being fully built at that point.
      WidgetsFlutterBinding.ensureInitialized()
          .addPostFrameCallback((_) => requestATTPlugin());
      debugPrint('👉 ATT auth status: $_authStatus');
    } else {
      debugPrint('👉 ATT: not an iOS platform');
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> requestATTPlugin() async {
    if (kIsWeb && !Platform.isIOS) {
      return;
    }
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    setState(() => _authStatus = '$status');
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();
      debugPrint('👉 ATT: show ATT dialog');
      setState(() => _authStatus = '$status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
