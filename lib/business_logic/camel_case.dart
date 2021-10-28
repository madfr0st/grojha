class CamelCase{
  static String convert(String string){
    List<String> list = string.split("");
    list[0] = list[0].toUpperCase();
    String ans = "";
    for(int i=0;i<list.length;i++){
      ans+=list[i];
    }
    return ans;
  }
}