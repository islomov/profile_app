import 'package:profile_app/model/abstract/person.dart';
import 'package:profile_app/model/family_member.dart';
import 'package:profile_app/model/friend.dart';

class User extends Person {
  late List<Person> friendsAndFamily;

  User(
      {required String name,
      required String sname,
      required String bdate,
      required Gender gender})
      : super(name: name, sname: sname, bdate: bdate, gender: gender);

  @override
  String whoAmI = " a user";

  List<FamilyMember> getFamilyMembers() {
    List<FamilyMember> list = List.empty(growable: true);
    for (int i = 0; i < friendsAndFamily.length; i++) {
      if (friendsAndFamily[i] is FamilyMember)
        list.add(friendsAndFamily[i] as FamilyMember);
    }
    return list;
  }

  List<Friend> getFriends() {
    List<Friend> list = List.empty(growable: true);
    for (int i = 0; i < friendsAndFamily.length; i++) {
      if (friendsAndFamily[i] is Friend)
        list.add(friendsAndFamily[i] as Friend);
    }
    return list;
  }
}
