abstract final class AppConstants {
  static const String emailRegex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";


 static List<String>type=[
    "Sport",
    "Birthday",
    "Meeting"
  ];

 static Map<String,String> lightImage={
   "Sport":"assets/images/sport_light.png",
   "Birthday" : "assets/images/Birthday light.png",
   "Meeting":"assets/images/Meeting light.png"
 };

  static Map<String,String> darkImage={
    "Sport":"assets/images/sport_dark.png",
    "Birthday" : "assets/images/Birthday dark.png",
    "Meeting":"assets/images/Meeting dark.png"
  };




}