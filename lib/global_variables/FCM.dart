import 'dart:convert';
import 'package:http/http.dart' as http;

class FCM {
  String token =
      "";

  String serverKey = "AAAA8lAs5eo:APA91bGCBJY7vfNH0OMEQ4U0wf7c90WNnMpQITNX60wGT_GLnTV4gnMnh3CfsLHTKhk02QFPAI1ZySVZanTNlqyMUpJVOL-N3UPRCSni5nYwmSSvVl4c0YnXJc8DtXySXwVLZv7QwB7q";

  Future<void> sendPushMessage() async {
    if (token == null) {
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
        body: constructFCMPayload(token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  String constructFCMPayload(String token) {
    return jsonEncode({
      'to': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': "5464",
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#5464) was created via FCM!',
      },
    });
  }
}
