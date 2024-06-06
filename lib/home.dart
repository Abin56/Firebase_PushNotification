import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_push_notification/api/access_firebase_Token.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();
  String deviceToken = '';
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  @override
  void initState() {
    userRequestPermission(); //user notification permission
    getDeviceToken(); // Get User Current Device token
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _title,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _body,
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              AccessTokenFirebase accessTokenGetter = AccessTokenFirebase();
              String token = await accessTokenGetter.getAccessToken();
              log(token);
              await sendPushMessage('sss', 'sss',token);
              //             String titleText = _title.text;
              //             String bodyText = _body.text.trim();

              //             //////////////
              //  await     sendPushMessage( titleText, bodyText)
              //                   .then((value) => log('Notificationsended'));
            },
            child: Container(
              height: 60,
              width: 200,
              color: Colors.green,
              child: const Center(
                child: Text("Submit"),
              ),
            ),
          )
        ],
      )),
    );
  }

  void getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        deviceToken = token ?? 'Not get the token ';
        log("User Device Token :: $token");
      });
      // saveDeviceTokenToFireBase(deviceToken);
    });
  }
}

void userRequestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    log('User granted provisional permission');
  } else {
    log('User declined or has not accepted permission');
  }
}

void saveDeviceTokenToFireBase(String deviceToken) async {
  await FirebaseFirestore.instance
      .collection("UserDeviceToken")
      .doc('user1')
      .set({'deviceToken': deviceToken}).then(
          (value) => log('Device Token Saved To FIREBASE'));
}

/// Sends a push notification with the given [body] and [title] to the device with the specified [device_id].
///
/// The [body] parameter represents the content of the notification.
/// The [title] parameter represents the title of the notification.
///
/// This function sends a POST request to the Firebase Cloud Messaging (FCM) server to send the notification.
/// The request includes the necessary headers and the message payload.
/// The server key is obtained from the [serverKey] variable.
///
/// If the request is successful (status code 200), a success message is printed.
/// If the request fails, an error message is printed along with the response status code and body.
/// If an exception occurs during the request, an exception message is printed.
///
/// Returns a [Future] that completes when the notification is sent.
Future<void> sendPushMessage(
    String body, String title, String serverKey) async {
  final Uri url = Uri.parse(
      'https://fcm.googleapis.com/v1/projects/pushnotification-23-may/messages:send');

  final Map<String, dynamic> message = {
    'message': {
      'token': device_id[0],
      'notification': {
        'title': title,
        'body': body,
      },
      'android': {
        'notification': {
          'title': 'Breaking News',
          'body': 'Check out the Top Story.',
          'click_action': 'TOP_STORY_ACTIVITY'
        },
        'data': {'story_id': 'story_12345'}
      },
      'apns': {
        'payload': {
          'aps': {'category': 'NEW_MESSAGE_CATEGORY'}
        },
      },
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'status': 'done',
        'body': body,
        'title': title,
      },
    },
  };

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully!');
    } else {
      print('Failed to send notification: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Exception caught sending notification: $e');
  }
}

List<String> device_id = [
  'dSfU0o3ySo6O_z30zZi4YL:APA91bE4jzDVsCFxmlYK2NTt52vNAQFH32mG2XnmwVGD8kyOFL1eXjDElQwwZ2xSudPW8ETc9WhGfmsc5D04aB7hMXaRrsl9Lm0et8f_F0tQHucMLpD1iDTJZxlf2yhfB3cSfvhHhMmZ'
];
