

class Notifications{

  String title;
  String body;
  int time;
  String senderId;
  String senderType;
  String image;
  String receiverToken;
  String receiverType;
  String receiverId;

  Notifications({this.title, this.body, this.time, this.senderId,
      this.senderType, this.image,this.receiverToken,this.receiverType,this.receiverId});

  @override
  String toString() {
    return 'Notifications{title: $title, body: $body, time: $time, senderId: $senderId, senderType: $senderType, image: $image, receiverToken: $receiverToken, receiverType: $receiverType, receiverId: $receiverId}';
  }
}