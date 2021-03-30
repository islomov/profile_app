import 'package:profile_app/model/abstract/person.dart';

class FamilyMember extends Person {

  String? profession;

  FamilyMember(
      {required String name,
      required String sname,
      required String bdate,
      required Gender gender, this.profession})
      : super(name: name, sname: sname, bdate: bdate, gender: gender);

  @override
  String whoAmI = "a family member";

  String getProfession() {
    return profession != null ? profession! : "Unemployed";
  }

}
