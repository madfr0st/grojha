
import 'package:firebase_database/firebase_database.dart';

  class Shop{

  String shopName;
  String shopCategory;
  String shopId;
  List<int> shopRating;
  String shopAddress;
  String shopStatus;
  String shopImage;

  Shop({String this.shopName, String this.shopCategory,String this.shopId,List<int> this.shopRating,
    String this.shopAddress,String this.shopStatus, this.shopImage}){if(this.shopImage==null || this.shopImage.length==0)
    this.shopImage = "https://firebasestorage.googleapis.com/v0/b/project-red-117.appspot.com/o/defaultImages%2FDefaultShopImage.png?alt=media&token=bb7b949f-fb1b-42a4-ae24-22f3d8bd22fd";
  }

  void toJson(){

  }

}

