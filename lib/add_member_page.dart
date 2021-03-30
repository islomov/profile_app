import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profile_app/model/family_member.dart';
import 'package:profile_app/model/friend.dart';
import 'package:profile_app/utils/data_manager.dart';
import 'package:profile_app/utils/helper.dart';

import 'model/abstract/person.dart';

class AddMemberPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddMemberPageState();
  }
}

class _AddMemberPageState extends State<AddMemberPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _snameController;
  late final TextEditingController _bDateController;
  late final TextEditingController _professionController;
  late final TextEditingController _friendController;
  String _dropDownGender = "female";
  String _dropDownMember = "friend";
  String _genderImage = "assets/female.png";
  bool _isProfessionVisible = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _snameController = TextEditingController();
    _bDateController = TextEditingController();
    _professionController = TextEditingController();
    _friendController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add friend or family member"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset(_genderImage),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Name'),
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: TextField(
                    controller: _snameController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Sure name'),
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: TextField(
                    controller: _bDateController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Birth date(mm/DD/yyyy)'),
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      value: _dropDownGender,
                      onChanged: (String? newValue) {
                        _onGenderSelected(newValue!);
                      },
                      items: <String>['male', 'female', 'other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList())),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      value: _dropDownMember,
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropDownMember = newValue!;
                          _isProfessionVisible =
                              _dropDownMember == "friend" ? false : true;
                        });
                      },
                      items: <String>['friend', 'family member']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList())),
              Visibility(
                child: Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: TextField(
                      controller: _professionController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Profession'),
                    )),
                visible: _isProfessionVisible,
              ),
              Visibility(
                child: Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: TextField(
                      controller: _friendController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Friend Relation'),
                    )),
                visible: !_isProfessionVisible,
              ),
            ],
          )),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child:
                ElevatedButton(onPressed: _addMember, child: Text("Add member")),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _snameController.dispose();
    _bDateController.dispose();
  }

  void _onGenderSelected(String newValue) {
    setState(() {
      _dropDownGender = newValue;
      if (_dropDownGender.toLowerCase() == "male") {
        _genderImage = "assets/male.png";
      } else if (_dropDownGender.toLowerCase() == "female") {
        _genderImage = "assets/female.png";
      } else {
        _genderImage = "assets/male_female.png";
      }
    });
  }

  void _addMember() {
    late Person person;
    String name = _nameController.text;
    String sname = _snameController.text;
    String bdate = _bDateController.text;
    Gender gender = HelperUtils.getGender(_dropDownGender);
    String profession = _professionController.text;
    String friendRelation = _friendController.text;
    if (_dropDownMember.contains("family")) {
      person =
          FamilyMember(
              name: name,
              sname: sname,
              bdate: bdate,
              gender: gender,
              profession: profession.isEmpty ? null : profession,
          );
    } else {
      person = Friend(
          name: name,
          sname: sname,
          bdate: bdate,
          gender: gender,
          relation: friendRelation.isEmpty ? null : friendRelation
      );
    }

    DataManager.addPerson(person);

    Navigator.pop(context);
  }
}
