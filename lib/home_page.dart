import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profile_app/add_member_page.dart';
import 'package:profile_app/model/abstract/person.dart';
import 'package:profile_app/model/user.dart';
import 'package:profile_app/utils/data_manager.dart';
import 'package:profile_app/utils/helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _snameController;
  late final TextEditingController _bDateController;
  String _familyMemberNames = "";
  String _friendNames = "";
  String _dropdownValue = "female";
  String _genderImage = "assets/female.png";
  User? user;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _snameController = TextEditingController();
    _bDateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  keyboardType: TextInputType.number,
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
                    value: _dropdownValue,
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
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Text(
                "Family Members",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Text(_familyMemberNames.isEmpty
                    ? "No family members yet"
                    : _familyMemberNames)),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                "Friends",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Text(
                    _friendNames.isEmpty ? "No friends yet" : _friendNames)),
            IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => AddMemberPage()))
                      .then((value) => {_updateUI()});
                }),
          ],
        )),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: ElevatedButton(
              onPressed: _validate, child: Text("Save & Preview")),
        )
      ],
    );
  }

  void _updateUI() {
    setState(() {
      _friendNames = DataManager.getFriendNames();
      _familyMemberNames = DataManager.getFamilyMemberNames();
    });
  }

  void _onGenderSelected(String newValue) {
    setState(() {
      _dropdownValue = newValue;
      if (_dropdownValue.toLowerCase() == "male") {
        _genderImage = "assets/male.png";
      } else if (_dropdownValue.toLowerCase() == "female") {
        _genderImage = "assets/female.png";
      } else {
        _genderImage = "assets/male_female.png";
      }
    });
  }

  void _validate() {
    String name = _nameController.text;
    String sname = _snameController.text;
    String bdate = _bDateController.text;
    Gender gender = HelperUtils.getGender(_dropdownValue);
    user = new User(name: name, sname: sname, bdate: bdate, gender: gender);
    user!.friendsAndFamily = DataManager.persons;
    showPreview();
  }

  void showPreview() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        width: 400.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(_genderImage),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Text(
                "Name:${user?.name}",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Text(
                "Sure name:${user?.sname}",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Text(
                "Gender:${user?.gender.toString()}",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Text(
                "Birth date:${user?.bdate}",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 35, 20, 10),
              child: Text(
                "Persons",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: user != null ? user!.friendsAndFamily.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    Person person = user!.friendsAndFamily[index];
                    return Container(
                      child: Center(
                          child: Text('${person.name} is ${person.whoAmI}')),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: ElevatedButton(
                  onPressed: () {
                    user = null;
                    Navigator.pop(context);
                  },
                  child: Text("Upload & Clear")),
            )
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
