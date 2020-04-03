
class Arr{
  String day;
  DateTime now;
  Arr(this.day,this.now);
}

List<Arr> details(){
    List<Arr> dayList=[];
    DateTime now=DateTime.now();
    for (var i = 0; i < 7; i++) {
      String day=getDay(now.weekday);
      dayList.add(Arr(day,now));
      now=now.add(Duration(days: 1));
    }
    return dayList;
}

String getDay(int x){
  switch (x) {
    case 1:
      return "MON";
      break;
    case 2:
      return "TUE";
      break;
    case 3:
      return "WED";
      break;
    case 4:
      return "THU";
      break;
    case 5:
      return "FRI";
      break;
    case 7:
      return "SUN";
      break;
    default:
      return "SAT";
      break;
  }
}