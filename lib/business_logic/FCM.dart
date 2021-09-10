import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grojha/Objects/notifications.dart';
import 'package:http/http.dart' as http;

class FCM {
  String token = "";


  String serverKey =
      "AAAA8lAs5eo:APA91bGCBJY7vfNH0OMEQ4U0wf7c90WNnMpQITNX60wGT_GLnTV4gnMnh3CfsLHTKhk02QFPAI1ZySVZanTNlqyMUpJVOL-N3UPRCSni5nYwmSSvVl4c0YnXJc8DtXySXwVLZv7QwB7q";

  void sendNotification({Notifications notifications}) {
    if (notifications.receiverToken == null) {
      DatabaseReference databaseReference = FirebaseDatabase.instance
          .reference()
          .child(notifications.receiverType)
          .child(notifications.receiverId)
          .child("deviceToken");

      databaseReference.once().then((value) {
        if (value.value != null) {
          notifications.receiverToken = value.value;
          _sendPushMessage(notifications: notifications);
        }
      });
    }
    else{
      _sendPushMessage(notifications: notifications);
    }
  }


  Future<void> _sendPushMessage({Notifications notifications}) async {
    if (notifications.receiverToken == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: _constructFCMPayload(notifications: notifications),
      );
      print('FCM request for device sent!');
      _uploadNotification(notifications: notifications);
    } catch (e) {
      print(e);
    }
  }

  String _constructFCMPayload({Notifications notifications}) {
    return jsonEncode({
      'to': notifications.receiverToken,
      // 'data': {
      //   'via': 'FlutterFire Cloud Messaging!!!',
      //   'count': "5464",
      // },
      "priority": "high",
      'notification': {
        'title': '${notifications.title}',
        'body': '${notifications.body}',
        "sound": "alert.wav"
      },
    });
  }

  static void init() {
    String uid = FirebaseAuth.instance.currentUser.uid;
    FirebaseMessaging.instance.getToken().then((token) {
      FirebaseDatabase.instance
          .reference()
          .child("users")
          .child(uid)
          .child("deviceToken")
          .set(token);
    });
  }

  void _uploadNotification({Notifications notifications}) {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child(
            "${notifications.receiverType}/${notifications.receiverId}/notifications");
    databaseReference.push().set({
      "title": notifications.title,
      "body": notifications.body,
      "time": ServerValue.timestamp,
      "image": notifications.image,
      "senderId": notifications.senderId,
      "senderType": notifications.senderType,
      "receiverType": notifications.receiverType,
    });
  }
}
