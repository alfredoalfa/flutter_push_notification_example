import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';



class PushNotificationsProvider {

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final _messagesStreamController = StreamController<String>.broadcast();

Stream<String> get messageStream => _messagesStreamController.stream;


  static Future<dynamic> onBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

initNotifications() async {

  await _firebaseMessaging.requestNotificationPermissions();
  final token = await _firebaseMessaging.getToken();

  print("============TOKEN============");
  print(token);

  _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessageHandler,
      onLaunch: onLaunch,
      onResume: onResume,
    );
 }

   Future<dynamic> onMessage(Map<String, dynamic> message) async {

    // print('=======ON MESSAGE=====');
    // print('Message: $message');

    final arguments = message['data']['comida'] ?? 'no-data';
    _messagesStreamController.sink.add( arguments );

    // print('Arguments: $arguments');
  }

   Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    
    final arguments = message['data']['comida'] ?? 'no-data';
     _messagesStreamController.sink.add( arguments );
  }

   Future<dynamic> onResume(Map<String, dynamic> message) async {

    final arguments = message['data']['comida'] ?? 'no-data';
     _messagesStreamController.sink.add( arguments );
  }

  dispose() {
    _messagesStreamController?.close();
  }

  
}