
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:sklite/SVM/SVM.dart';
// import 'package:sklite/base.dart';
// import 'package:sklite/ensemble/forest.dart';
// import 'package:sklite/naivebayes/naive_bayes.dart';
// import 'package:sklite/neighbors/neighbors.dart';
// import 'package:sklite/neural_network/neural_network.dart';
// import 'package:sklite/pipeline/pipeline.dart';
// import 'package:sklite/tree/tree.dart';
// import 'package:sklite/utils/exceptions.dart';
// import 'package:sklite/utils/io.dart';
// import 'package:sklite/utils/mathutils.dart';
import 'package:ml_preprocessing/ml_preprocessing.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:ml_algo/ml_algo.dart';



class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final formKey = GlobalKey<FormState>();
  DateTime datetime = DateTime(2022, 6, 26);
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _lightLevelController = TextEditingController();
  final TextEditingController _roomTemperatureController = TextEditingController();
  final TextEditingController _roomHumidityController = TextEditingController();
  final TextEditingController _productionController = TextEditingController();
  // final TextEditingController _dateController = TextEditingController();


  final CollectionReference _mushroom = FirebaseFirestore.instance.collection('mushroom');

  //await _mushroom.add({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.update({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.doc({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.doc(productId).delete();

  Future <void> _create([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null){
      _batchController.text = documentSnapshot['batch'].toString();
      _lightLevelController.text = documentSnapshot['lightLevel'].toString();
      _roomTemperatureController.text = documentSnapshot['roomTemp'].toString();
      _roomHumidityController.text = documentSnapshot['humidity'].toString();
      _productionController.text = documentSnapshot['outcome'].toString();
      // _dateController.text = documentSnapshot['date'].toString();
    }

  } //Future void _create

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(height: 50),
            Center(
              child: Text(
                "Enter your data",
                style: TextStyle(
                  color: Color(0xffdbc791),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),

              ),
            ),
            SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  TextFormField(
                    controller: _batchController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Batch Number"
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Username cannot be empty!";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _lightLevelController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Light Level(Lumens)"
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Password cannot be empty!";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _roomTemperatureController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Room Temperature"
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Username cannot be empty!";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _roomHumidityController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText: "Humidity(Milibar)"
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Username cannot be empty!";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 30),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    icon: Icon(Icons.add),
                    label: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black
                      ),
                    ),
                    onPressed: () async {
                      //final user = User(name: co)
                      //createUser();

                      final double? batchNumber = double.tryParse(
                          _batchController.text);
                      final double? lightLevel = double.tryParse(
                          _lightLevelController.text);
                      final double? roomTemp = double.tryParse(
                          _roomTemperatureController.text);
                      final double? humidity = double.tryParse(
                          _roomHumidityController.text);
                      final String? outcome = (_productionController.text);
                      final String? datetime = DateTime.now().toString();

                      if (batchNumber != null) {
                        await _mushroom.add({
                          "batch": batchNumber,
                          "lightLevel": lightLevel,
                          "roomTemp": roomTemp,
                          "humidity": humidity,
                          "outcome": outcome,
                          "date": datetime
                        });
                        _batchController.text = '';
                        _lightLevelController.text = '';
                        _roomTemperatureController.text = '';
                        _roomHumidityController.text = '';
                        _productionController.text = '';
                      }
                    },
                  ),
                  SizedBox(height: 20),

                ],
              ),
            ),

          ],
        ),

      ),
    );
  }



    // Future createUser() async {
    //   final docUser = FirebaseFirestore.instance.collection('users').doc(
    //       'my-id');
    //
    //   // final json = { //a map
    //   //   'name': name,
    //   //   'age': 21,
    //   //   'birthday': DateTime(2001,7,28),
    //   // };
    //
    //   final user = User(
    //     id: docUser.id,
    //     name: name,
    //     age: 21,
    //     birthday: DateTime(2001, 7, 28),
    //   );
    //   final json = user.toJson();
    //
    //   //Create document and write data to firebase
    //   await docUser.set(json);
    // } //createUser()


  // class User{
  // String id;
  // final String name;
  // final int age;
  // final DateTime birthday;
  //
  // User({
  // this.id = '',
  // required this.name,
  // required this.age,
  // required this.birthday,
  // });
  //
  // //To convert to json
  // Map<String, dynamic> toJson() => {
  // 'id': id,
  // 'name': name,
  // 'age': age,
  // 'birthday': birthday,
  // };
  // }

}