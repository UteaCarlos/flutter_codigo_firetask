import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/models/user_model.dart';

class MyServiceFirestore {
  String collection;
  MyServiceFirestore({required this.collection});

  late CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(collection);

//añadir
  Future<String> addTask(TaskModel model) async {
    DocumentReference documentReference =
        await _collectionReference.add(model.toJson());
    String id = documentReference.id;
    return id;
  }
//borrar

  Future<void> finishiedTask(String taskId) async {
    await _collectionReference.doc(taskId).update(
      {
        "status": false,
      },
    );
  }

  Future<String> addUser(UserModel userModel) async {
    DocumentReference documentReference =
        await _collectionReference.add(userModel.toJson());
    return documentReference.id;
  }

 //se de verificar usuario

  Future<bool> cherckUser(String email) async{
   QuerySnapshot collection = await _collectionReference.where("email", isEqualTo: email).get();
   if(collection.docs.isNotEmpty){
    return true;
   } else{
    return false;
   }
  }



}
