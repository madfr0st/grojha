import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  String userName;
  String userImage;
  String userPhoneNumber;
  String userAddress;

  AppUser({this.userAddress, this.userName,this.userPhoneNumber,this.userImage}){
    if(userImage==null || userImage.length==0){
      userImage = "https://firebasestorage.googleapis.com/v0/b/project-red-117.appspot.com/o/defaultImages%2Fprofile_pic.png?alt=media&token=3c4b2696-6199-4f7a-af88-d6be963e2af7";
    }
  }

  @override
  String toString() {
    return 'AppUser{userName: $userName, userImage: $userImage, userPhoneNumber: $userPhoneNumber, userAddress: $userAddress}';
  }
}
