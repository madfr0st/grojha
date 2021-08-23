import 'package:flutter/material.dart';
import 'package:grojha/Objects/notifications.dart';



import '../../../constants.dart';
import '../../../size_config.dart';

class SingleNotificationCard extends StatelessWidget {
  const SingleNotificationCard({Key key, this.notifications}) : super(key: key);

  final Notifications notifications;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
      height: getProportionateScreenWidth(80),
      width: double.infinity,
      //color: Colors.redAccent,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: getProportionateScreenWidth(100),
        width: double.infinity,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Container(
          //  color: Colors.redAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: getProportionateScreenHeight(18),
                //  color: Colors.grey,
                child: Row(
                  children: [
                    Icon(
                      Icons.label_important,
                      color: kPrimaryColor,
                      size: getProportionateScreenWidth(15),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(5),
                    ),
                    Text(
                      notifications.title,
                      style: TextStyle(
                        height: 1.1,
                        fontSize: getProportionateScreenWidth(15),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: getProportionateScreenHeight(34),
                width: double.infinity,
                //  color: Colors.grey,
                alignment: Alignment.centerLeft,
                child:  Text(
                  notifications.body,
                  style: TextStyle(
                      height: 1,
                      fontSize: getProportionateScreenWidth(12),
                      //fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
              Container(
                height: getProportionateScreenHeight(18),
                //    color: Colors.grey,
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      timesStampToDate(notifications.time),
                      style: TextStyle(
                        height: 1,
                        fontSize: getProportionateScreenWidth(12),
                        fontWeight: FontWeight.bold,

                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  String orderNumber(int a) {
    String num = a.toString();
    int len = num.length;

    for (int i = len; i < 6; i++) {
      num = "0" + num;
    }
    return num;
  }

  String timesStampToDate(int timestamp) {
    Map<String, String> monthMap = {
      "1": "Jan",
      "2": "Feb",
      "3": "Mar",
      "4": "Apr",
      "5": "May",
      "6": "Jun",
      "7": "Jul",
      "8": "Aug",
      "9": "Sep",
      "10": "Oct",
      "11": "Nov",
      "12": "Dec",
    };
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();
    int hours = date.hour;
    String minutes = date.minute.toString();
    int quo = hours - 12;
    String extension = "am";
    if (quo >= 0) {
      extension = "pm";
      hours -= 12;
    }

    String hr = hours.toString();

    if (minutes.length == 1) {
      minutes = "0" + minutes;
    }

    if (hours.toString().length == 1) {
      hr = "0" + hr;
    }

    String time = day +
        "/" +
        monthMap[month] +
        "/" +
        year +
        "    " +
        hr +
        ":" +
        minutes +
        " " +
        extension;

    return time.toString();
  }

}
