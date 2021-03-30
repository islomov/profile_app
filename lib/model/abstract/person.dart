
enum Gender{
  male,
  female,
  other
}


abstract class Person{
  String name;
  String sname;
  String bdate;
  Gender gender;

  abstract String whoAmI;

  Person({
    required this.name,
    required this.sname,
    required this.bdate,
    required this.gender});
  
}