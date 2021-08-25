import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/notifications.dart';

class GetNotifications {
  static int notificationCount = 0;
  static List<Notifications> notificationList = [];

  GetNotifications() {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("users/$uid/notifications");

    databaseReference.once().then((snapShot) {
      if (snapShot.value != null) {
        Map<dynamic, dynamic> map = snapShot.value;
        notificationList.clear();
        notificationCount = 0;
        map.forEach((key, val) {
          notificationCount++;
          notificationList.add(new Notifications(
            title: val["title"],
            body: val["body"],
            time: val["time"],
          ));
        });
      }
    });
  }
}
