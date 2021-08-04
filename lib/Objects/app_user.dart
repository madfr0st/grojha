import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  String userName;
  String userImage;
  String userPhoneNumber;
  String userAddress;

  AppUser({String this.userAddress,String this.userName,String this.userPhoneNumber,String this.userImage});

  @override
  String toString() {
    return 'AppUser{userName: $userName, userImage: $userImage, userPhoneNumber: $userPhoneNumber, userAddress: $userAddress}';
  }
}
