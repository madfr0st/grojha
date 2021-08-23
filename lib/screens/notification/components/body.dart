import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/notifications.dart';
import 'package:grojha/business_logic/FCM.dart';
import 'package:grojha/components/default_button.dart';
import 'package:grojha/screens/notification/components/single_notification_card.dart';


class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    List<Notifications> list = [];

    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("users/$uid/notifications");

    int count =0;

    return SafeArea(
        child: FutureBuilder(
      future: databaseReference.once(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          try {
            Map<dynamic, dynamic> map = snapShot.data.value;
            list.clear();
            map.forEach((key, val) {
              list.add(new Notifications(
                title: val["title"],
                body: val["body"],
                time: val["time"],
              ));
            });

            return SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                      list.length, (index) => SingleNotificationCard(notifications: list[index],)),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: DefaultButton(
                      text: "Clear Notifications",
                      press: (){
                        databaseReference.set({});
                        Navigator.pop(context);
                      },
                    ),
                  )
                  ,
                ],
              ),
            );
          } catch (e) {
            print(e);
            return Center(
              child: DefaultButton(
                text: "Send push Notification",
                press: (){
                  count++;
                  Notifications noti = new Notifications(
                    receiverToken: "fGfLkCITTkGpTTWzZxxHia:APA91bFootJbVTP7DK4uk7MZShdpI75NuoqxzYsQnmJu683LyC6fl4urinxcXRUGgecZCG5Va95TKzsrrmaF84Euau26292BqLAeU42OXA3oZZUYDZMsO4lojcR8t44vE04zJS2yLMnm",
                    receiverType: "shops",
                    receiverId:"LVFggWiBrfgR2ayPSdSQF7PGNY33",
                    senderId: uid,
                    senderType: "users",
                    body: count.toString(),
                    title: "Notification count",
                  );

                  FCM().sendNotification(notifications: noti);

                },
              ),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
