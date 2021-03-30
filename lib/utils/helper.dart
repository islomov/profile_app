import 'package:profile_app/model/abstract/person.dart';

class HelperUtils {

  static Gender getGender(String value) {
    if (value == "male") {
      return Gender.male;
    } else if (value == "female") {
      return Gender.female;
    } else {
      return Gender.other;
    }
  }

}
