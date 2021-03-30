import 'package:profile_app/model/abstract/person.dart';

class Friend extends Person {

  String? relation;

  Friend(
      {required String name,
      required String sname,
      required String bdate,
      required Gender gender, this.relation})
      : super(name: name, sname: sname, bdate: bdate, gender: gender);

  @override
  String whoAmI = "a friend";

  String? getFriendRelation(){
    return relation;
  }

}