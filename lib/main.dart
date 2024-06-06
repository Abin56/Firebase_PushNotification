import 'dart:developer';

import 'package:f_push_notification/background.dart';
import 'package:f_push_notification/chart_ui.dart';
import 'package:f_push_notification/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  log('Handling  a background message ${message.messageId}');
}
void main()async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
 
      home:  BackGroundScreen(),
    );
  }
}