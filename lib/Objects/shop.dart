
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
    this.shopImage = "https://picsum.photos/250?image=9";
  }

  void toJson(){

  }

}

