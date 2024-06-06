import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
class BackGroundScreen extends StatefulWidget {
  @override
  _BackGroundScreenState createState() => _BackGroundScreenState();
}

class _BackGroundScreenState extends State<BackGroundScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startForegroundService();
  }

  void _startForegroundService()  {
     FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_channel_id',
        channelName: 'Foreground Service Channel',
        channelDescription: 'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.drawable,
          resPrefix: ResourcePrefix.ic,
          name: 'ic_launcher',
        ),
        visibility: NotificationVisibility.VISIBILITY_PUBLIC,
        enableVibration: false,
        playSound: false,
        showWhen: true,
        // autoCancel: false,
        // ongoing: true,
      ),
      iosNotificationOptions: IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        interval: 5000,
        isOnceEvent: false,
        autoRunOnBoot: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );

     FlutterForegroundTask.startService(
      notificationTitle: 'Foreground Service',
      notificationText: 'Running',
      callback: startCallback,
    );
  }

  static void startCallback() {
    FlutterForegroundTask.setTaskHandler(MyTaskHandler());
  }

  void _updateProgress(double progress) {
    setState(() {
      _progress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Foreground Service Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(value: _progress),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FlutterForegroundTask.updateService(
                  notificationTitle: 'Foreground Service',
                  notificationText: 'Progress: ${(_progress * 100).toStringAsFixed(0)}%',
                );
                // Simulate a progress update
                for (int i = 0; i <= 100; i++) {
                  await Future.delayed(Duration(milliseconds: 100));
                  _updateProgress(i / 100);
                  await FlutterForegroundTask.updateService(
                    notificationTitle: 'Foreground Service',
                    notificationText: 'Progress: ${i}%',
                  );
                }
              },
              child: Text('Start Progress'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    // Implement your background task initialization code here.
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    
    // Implement your periodic task code here.
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    // Implement your background task cleanup code here.
  }

  @override
  void onButtonPressed(String id) {
    // Implement your code for handling notification button presses.
  }

  @override
  void onNotificationPressed() {
    // Implement your code for handling notification presses.
  }
  
  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) {
    // TODO: implement onRepeatEvent
  }
}