import 'package:flutter/material.dart';

import '../size_config.dart';

class Utils{
  static AppBar appBar({ String title}){
    return AppBar(
      title: Text(title,style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),),
    );
  }


  static Container showError({ Set<String> set}){
    List<String> list = [];
    list.addAll(set);
    return Container(
        child: Column(
          children: [
            ...List.generate(set.length, (index) => _errorLine(text:list[index]))
          ],
        ),
    );
  }

  static Container _errorLine({ String text}){
    return Container(
      width: double.infinity,
      height: getProportionateScreenWidth(25),
      margin: EdgeInsets.all(getProportionateScreenWidth(5)),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Icon(Icons.error,color: Colors.red,),
          SizedBox(width: getProportionateScreenWidth(10),),
          Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: getProportionateScreenWidth(12),color: Colors.red),),
        ],
      )
    );
  }

  static String convertToCamelCase(String string){
    List<String> list = string.split("");
    list[0] = list[0].toUpperCase();
    String ans = "";
    for(int i=0;i<list.length;i++){
      ans+=list[i];
    }
    return ans;
  }
}