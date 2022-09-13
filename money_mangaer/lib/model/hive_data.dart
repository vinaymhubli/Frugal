import 'package:hive/hive.dart';

class DbHelper{
 late Box box;

DbHelper(){
openBox();
}

openBox(){
  box=Hive.box('money');
}
Future deleteData(int index)async{
  await box.deleteAt(index);
}
Future addData(int amount, DateTime date,String note,String type, )async{
  var value={'amount': amount,'date':date,'type':type,'note':note};
  box.add(value);
}

Future<Map>fetch(){
  if (box.values.isEmpty) {
    return Future.value({});
  }else{
    return Future.value(box.toMap());
  }
}

}
