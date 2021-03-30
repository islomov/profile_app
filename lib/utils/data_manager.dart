import 'package:profile_app/model/abstract/person.dart';
import 'package:profile_app/model/family_member.dart';
import 'package:profile_app/model/friend.dart';
import 'package:profile_app/model/user.dart';

class DataManager {

  static List<Person> persons = List.empty(growable: true);

  static void addPerson(Person person) {
    persons.add(person);
  }



  static String getFamilyMemberNames() {
    String names = "";
    for (int i = 0; i < persons.length; i++) {
      Person person = persons[i];
      if (person is FamilyMember) {
        if (i == persons.length - 1)
          names += "${person.name} ${person.sname}";
        else
          names += "${person.name} ${person.sname},";
      }
    }
    return names;
  }

  static String getFriendNames() {
    String names = "";
    for (int i = 0; i < persons.length; i++) {
      Person person = persons[i];
      if (person is Friend) {
        if (i == persons.length - 1)
          names += "${person.name} ${person.sname}";
        else
          names += "${person.name} ${person.sname},";
      }
    }
    return names;
  }
}
